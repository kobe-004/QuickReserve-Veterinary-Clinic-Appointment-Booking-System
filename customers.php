<?php
session_start();

// Debug information
error_log("Session data in customers: " . print_r($_SESSION, true));

// Session validation
if (!isset($_SESSION['user_id'])) {
    header("Location: ../login.html?error=" . urlencode("No user ID in session"));
    exit();
}

if (!isset($_SESSION['is_admin']) || !$_SESSION['is_admin']) {
    header("Location: ../login.html?error=" . urlencode("Not an admin account"));
    exit();
}

// Database connection with debug info
try {
    require_once('../includes/db_connect.php');
    error_log("Database connection successful");
} catch (Exception $e) {
    error_log("Database connection error in customers.php: " . $e->getMessage());
    die("Database connection failed. Please check the error logs for details.");
}

// Function to generate customers XML
function generateCustomersXML($conn)
{
    $xml = new DOMDocument('1.0', 'UTF-8');
    $xml->formatOutput = true;

    // Create root element
    $customers = $xml->createElement('customers');
    $customerList = $xml->createElement('customer_list');
    $customers->appendChild($customerList);
    $xml->appendChild($customers);

    // Query to get customer information
    $query = "SELECT u.id, u.email, u.contact, pi.first_name, pi.middle_name, pi.last_name,
              (SELECT COUNT(*) FROM appointments WHERE user_id = u.id) as total_appointments,
              (SELECT MAX(appointment_date) FROM appointments WHERE user_id = u.id) as last_appointment
              FROM users u
              LEFT JOIN personal_info pi ON u.id = pi.id
              ORDER BY u.id DESC";

    $result = $conn->query($query);

    while ($row = $result->fetch_assoc()) {
        $customer = $xml->createElement('customer');

        // Create customer elements
        $fullName = $xml->createElement(
            'full_name',
            $row['first_name'] . ' ' .
            ($row['middle_name'] ? $row['middle_name'] . ' ' : '') .
            $row['last_name']
        );
        $email = $xml->createElement('email', $row['email']);
        $contact = $xml->createElement('contact', $row['contact']);
        $totalAppointments = $xml->createElement('total_appointments', $row['total_appointments']);
        $lastAppointment = $xml->createElement(
            'last_appointment',
            $row['last_appointment'] ? $row['last_appointment'] : 'No appointments yet'
        );
        $status = $xml->createElement('status', 'Active');

        // Get pets for this customer
        $pets = $xml->createElement('pets');
        $petQuery = "SELECT pet_name, species, breed FROM pet_info WHERE user_id = ?";
        $stmt = $conn->prepare($petQuery);
        $stmt->bind_param("i", $row['id']);
        $stmt->execute();
        $petResult = $stmt->get_result();

        while ($petRow = $petResult->fetch_assoc()) {
            $pet = $xml->createElement('pet');
            $pet->appendChild($xml->createElement('name', $petRow['pet_name']));
            $pet->appendChild($xml->createElement('species', $petRow['species']));
            $pet->appendChild($xml->createElement('breed', $petRow['breed']));
            $pets->appendChild($pet);
        }

        // Append all elements to customer
        $customer->appendChild($fullName);
        $customer->appendChild($email);
        $customer->appendChild($contact);
        $customer->appendChild($totalAppointments);
        $customer->appendChild($pets);
        $customer->appendChild($lastAppointment);
        $customer->appendChild($status);

        // Add customer to list
        $customerList->appendChild($customer);
    }

    // Save XML file
    $xml->save('xml/customers.xml');
}

// Check if XSL extension is loaded
if (!extension_loaded('xsl')) {
    die("Error: PHP XSL extension is not enabled. Please enable php_xsl.dll in your php.ini file.");
}

// Generate fresh XML
generateCustomersXML($conn);

// Load XML file
$xml = new DOMDocument();
$xml->load('xml/customers.xml');

// Load XSL file
$xsl = new DOMDocument();
$xsl->load('xsl/customers.xsl');

// Create XSLT processor
$proc = new XSLTProcessor();
$proc->importStyleSheet($xsl);

// Transform XML
$transformed_xml = $proc->transformToXML($xml);
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customers - QuickReserve Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet" />
    <link href="css/dashboard.css" rel="stylesheet" />
    <style>
        #main-content {
            margin-left: 220px;
            padding: 20px;
            width: calc(100% - 260px);
        }

        .customers-container {
            background: #e0e0e0;
            border-radius: 15px;
            padding: 20px;
        }

        .customer-list {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .customer-row {
            background: #d3d3d3;
            padding: 15px;
            border-radius: 10px;
            display: grid;
            grid-template-columns: 2fr 2fr 2fr 1fr;
            align-items: center;
            gap: 15px;
        }

        .customer-info {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .customer-name {
            font-weight: 500;
            color: #333;
        }

        .customer-email,
        .customer-contact {
            font-size: 0.9em;
            color: #666;
        }

        .pet-info {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .pet-name {
            color: #444;
        }

        .appointment-info {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .total-appointments,
        .last-appointment {
            font-size: 0.9em;
            color: #666;
        }

        .status-badge {
            text-align: center;
        }

        .status {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 15px;
            background: #4CAF50;
            color: white;
            font-size: 0.9em;
        }
    </style>
</head>

<body>
    <?php include 'html/sidebaradmin.html'; ?>
    <div id="main-content">
        <?php echo $transformed_xml; ?>
    </div>
</body>

</html>