-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 22, 2025 at 03:07 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `test`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_users`
--

CREATE TABLE `admin_users` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `state` tinyint(4) NOT NULL COMMENT '1 for active/enabled, 0 for disabled',
  `password` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_users`
--

INSERT INTO `admin_users` (`user_id`, `user_name`, `state`, `password`) VALUES
(10001, 'Σάρα Ντόγρι', 1, ''),
(10003, 'admin', 1, 'pwd');

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `row_id` int(11) NOT NULL,
  `course_id` varchar(11) NOT NULL,
  `course_name` varchar(100) DEFAULT NULL,
  `exam_period` int(11) NOT NULL COMMENT 'Semester',
  `latest_quiz` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`row_id`, `course_id`, `course_name`, `exam_period`, `latest_quiz`, `user_id`, `active`) VALUES
(1, 'ΥΠ16', 'Βάσεις Δεδομένων', 4, 202506151750024098, 10001, 1),
(2, 'ΥΠ02', 'Προγραμματισμός Ι', 1, 0, 10001, 0),
(3, 'ΕΠ19', 'Εξόρυξη Δεδομένων', 7, 0, 10001, 0),
(4, 'ΥΠ23', 'Τεχνητή Νοημοσύνη', 6, 202506211750508720, 10001, 1);

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `row_id` int(11) NOT NULL,
  `v_id` bigint(20) NOT NULL,
  `course_id` varchar(11) NOT NULL,
  `exam_period` int(11) NOT NULL COMMENT 'Semester ',
  `year` int(11) NOT NULL,
  `question_id` varchar(6) NOT NULL,
  `question_text` longtext NOT NULL,
  `question_category` mediumtext NOT NULL,
  `question_choices` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `question_weight` int(11) NOT NULL COMMENT 'This is calculated by the sum of the choices score',
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`row_id`, `v_id`, `course_id`, `exam_period`, `year`, `question_id`, `question_text`, `question_category`, `question_choices`, `question_weight`, `date`) VALUES
(1, 202506151750024098, 'ΥΠ16', 7, 2025, '1', '\r\nΠώς μπορώ να αλλάξω ένα πεδίο από υποχρεωτικό σε μη υποχρεωτικό;\r\n  ', 'sql', '[{\"id\":1,\"text\":\"Με χρήση της alter table\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"Με χρήση της modify table\",\"score\":0,\"status\":\"wrong\"},{\"id\":3,\"text\":\"Με χρήση της update column\",\"score\":0,\"status\":\"wrong\"},{\"id\":4,\"text\":\"Διαγράφω και ξαναφτιάχνω σωστά τον πίνακα\",\"score\":5,\"status\":\"wrong\"}]', 15, '2025-06-15 21:48:18'),
(2, 202506151750024098, 'ΥΠ16', 7, 2025, '2a', '    \r\n   Όταν μια εσωτερική συνένωση δύο πινάκων δεν εντοπίσει γραμμές που ταιριάζουν, τι μπορούμε να δοκιμάσουμε για να φέρουμε όλες τις γραμμές κάθε πίνακα;\r\n  ', 'relationalalg', '[{\"id\":1,\"text\":\"full outer join\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"inner join\",\"score\":0,\"status\":\"wrong\"},{\"id\":3,\"text\":\"outer join\",\"score\":5,\"status\":\"wrong\"},{\"id\":4,\"text\":\"right outer join\",\"score\":0,\"status\":\"wrong\"}]', 15, '2025-06-15 21:48:18'),
(3, 202506151750024098, 'ΥΠ16', 7, 2025, '2b', '    \r\n   Ποια συνένωση δύο πινάκων εντοπίζει μόνο γραμμές που ταιριάζουν μεταξύ των πινάκων;\r\n  ', 'relationalalg', '[{\"id\":1,\"text\":\"natural join\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"left outer join\",\"score\":0,\"status\":\"wrong\"},{\"id\":3,\"text\":\"right outer join\",\"score\":0,\"status\":\"wrong\"},{\"id\":4,\"text\":\"join\",\"score\":5,\"status\":\"wrong\"}]', 15, '2025-06-15 21:48:18'),
(4, 202506151750024098, 'ΥΠ16', 7, 2025, '3', '    \r\n   Ποια πράξη της σχεσιακής άλγεβρας επιλέγει τις πλειάδες που υπάρχουν μόνο στο πρώτο από τα δύο σύνολα αποτελεσμάτων;\r\n  ', 'relationalalgebra', '[{\"id\":1,\"text\":\"Αφαίρεση\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"Ένωση\",\"score\":0,\"status\":\"wrong\"},{\"id\":3,\"text\":\"Union\",\"score\":0,\"status\":\"wrong\"},{\"id\":4,\"text\":\"Τομή\",\"score\":0,\"status\":\"wrong\"}]', 10, '2025-06-15 21:48:18'),
(5, 202506151750024098, 'ΥΠ16', 7, 2025, '4', '    \r\n   Με ποιο τρόπο είναι σωστό να συνδυάσουμε δεδομένα από δύο πίνακες R1(b,e), R2(a,c,d);\r\n  ', 'relationalalgebra', '[{\"id\":1,\"text\":\"Με cartesian product.\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"Με join στο c.\",\"score\":0,\"status\":\"wrong\"},{\"id\":3,\"text\":\"Με intersection.\",\"score\":0,\"status\":\"wrong\"},{\"id\":4,\"text\":\"Με φωλιασμένα ερωτήματα.\",\"score\":5,\"status\":\"wrong\"}]', 15, '2025-06-15 21:48:18'),
(6, 202506151750024098, 'ΥΠ16', 7, 2025, '5a', '    \r\n  Τι κάνουμε αν σε μια οντότητα Α έχει ένα σύνθετο γνώρισμα;\r\n  ', 'attributes', '[{\"id\":1,\"text\":\"Το αναλύουμε σε απλά γνωρίσματα και προσθέτουμε στη σχέση Α τις αντίστοιχες στήλες.\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"Φτιάχνουμε νέο πίνακα με ξένο κλειδί προς το πρωτεύον κλειδί της Α και το σύνθετο γνώρισμα ως στήλη.\",\"score\":0,\"status\":\"wrong\"},{\"id\":3,\"text\":\"Προσθέτουμε ένα γνώρισμα τύπου Object.\",\"score\":0,\"status\":\"wrong\"},{\"id\":4,\"text\":\"Προσθέτουμε ένα γνώρισμα τύπου Varchar και αποθηκεύουμε τα πάντα ως text.\",\"score\":0,\"status\":\"wrong\"}]', 10, '2025-06-15 21:48:18'),
(7, 202506151750024098, 'ΥΠ16', 7, 2025, '5b', '    \r\n  Τι κάνουμε αν σε μια οντότητα Α έχει ένα απλό μονότιμο γνώρισμα;\r\n  ', 'attributes', '[{\"id\":1,\"text\":\"Προσθέτουμε μια στήλη στο σχετικό πίνακα.\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"Φτιάχνουμε νέο πίνακα με τόσες στήλες όσες αντιστοιχούν στο γνώρισμα.\",\"score\":0,\"status\":\"wrong\"},{\"id\":3,\"text\":\"Φτιάχνουμε νέο πίνακα με ξένο κλειδί προς το πρωτεύον κλειδί της Α και το μονότιμο γνώρισμα ως στήλη.\",\"score\":0,\"status\":\"wrong\"},{\"id\":4,\"text\":\"Προσθέτουμε ένα γνώρισμα τύπου Varchar και αποθηκεύουμε τα πάντα ως text.\",\"score\":5,\"status\":\"wrong\"}]', 15, '2025-06-15 21:48:18'),
(8, 202506151750024098, 'ΥΠ16', 7, 2025, '5c', '    \r\n  Τι κάνουμε αν σε μια οντότητα Α έχει ένα σύνθετο πλειότιμο γνώρισμα;\r\n  ', 'attributes', '[{\"id\":1,\"text\":\"Φτιάχνουμε νέο πίνακα με ξένο κλειδί προς το πρωτεύον κλειδί της Α και προσθέτουμε στον πίνακα τόσες στήλες όσες αντιστοιχούν στο σύνθετο γνώρισμα.\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"Φτιάχνουμε νέο πίνακα με τόσες στήλες όσες αντιστοιχούν στο γνώρισμα.\",\"score\":0,\"status\":\"wrong\"},{\"id\":3,\"text\":\"Φτιάχνουμε νέο πίνακα με ξένο κλειδί προς το πρωτεύον κλειδί της Α και το σύνθετο γνώρισμα ως στήλη.\",\"score\":5,\"status\":\"wrong\"},{\"id\":4,\"text\":\"Προσθέτουμε ένα γνώρισμα τύπου Varchar και αποθηκεύουμε τα πάντα ως text.\",\"score\":0,\"status\":\"wrong\"}]', 15, '2025-06-15 21:48:18'),
(9, 202506151750024098, 'ΥΠ16', 7, 2025, '6a', '    \r\n  Πώς αποτυπώνουμε μια ολική εξειδίκευση της οντότητας Εργαζόμενος σε Έμμισθο και Ωρομίσθιο, όταν η μόνη τους διαφορά είναι ο μισθός ο οποίος στη μία περίπτωση είναι με το μήνα και στην άλλη με την ώρα;\r\n  ', 'entityrelationshipinherit', '[{\"id\":1,\"text\":\"Με μια σχέση Εργαζόμενος και 2 επιπλέον στήλες <Μισθός, ΤύποςΜισθού>.\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"Με δύο σχέσεις για Έμμισθο και Ωρομίσθιο αντίστοιχα. Η σχέση Έμμισθος θα έχει στήλες <ΕργID,Μισθός>.\",\"score\":0,\"status\":\"wrong\"},{\"id\":3,\"text\":\"Με τρεις σχέσεις. Μία για κάθε οντότητα.\",\"score\":5,\"status\":\"wrong\"},{\"id\":4,\"text\":\"Με μια σχέση Εργαζόμενος για όλους τους Έμμισθους και μια επιπλέον για τους Ωρομίσθιους με στήλες <ΕργID,Μισθός>.\",\"score\":0,\"status\":\"wrong\"}]', 15, '2025-06-15 21:48:18'),
(10, 202506151750024098, 'ΥΠ16', 7, 2025, '6b', '    \r\n  Πώς αποτυπώνουμε μια μερική εξειδίκευση της οντότητας Εργαζόμενος σε Τεχνικό και Μηχανικό, όταν οι Τεχνικοί έχουν Βαθμό ενώ οι Μηχανικοί Ειδικότητα;\r\n  ', 'entityrelationshipinherit', '[{\"id\":1,\"text\":\"Με τρεις σχέσεις. Μία για κάθε οντότητα. Ο Εργαζόμενος με τα πεδία του, οι Τεχνικός,Μηχανικός με ένα ξένο κλειδί ΕργID και το επιπλέον γνώρισμα που τους αντιστοιχεί.\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"Με μια σχέση Εργαζόμενος και 2 επιπλέον στήλες <Τεχνικός, Μηχανικός>.\",\"score\":5,\"status\":\"wrong\"},{\"id\":3,\"text\":\"Με δύο πίνακες, έναν για τους τεχνικούς και έναν για τους μηχανικούς με όλα τα γνωρίσματα του εργαζόμενου ο καθένας και το επιπλέον γνώρισμα αντίστοιχα.\",\"score\":0,\"status\":\"wrong\"},{\"id\":4,\"text\":\"Με τον Εργαζόμενο και έναν δεύτερο πίνακα Ειδικευμένοι με όλες τις στήλες και 2 επιπλέον.\",\"score\":0,\"status\":\"wrong\"}]', 15, '2025-06-15 21:48:18'),
(11, 202506151750024098, 'ΥΠ16', 7, 2025, '7', '    \r\n  Ο όρος ...... χρησιμοποιείται για να αναφερθούμε σε μια στήλη ενός πίνακα που οι τιμές της αναφέρονται σε στήλη κάποιου άλλου πίνακα.\r\n  ', 'basics', '[{\"id\":1,\"text\":\"ξένο κλειδί\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"πλειάδα\",\"score\":0,\"status\":\"wrong\"},{\"id\":3,\"text\":\"πρωτεύον κλειδί\",\"score\":5,\"status\":\"wrong\"},{\"id\":4,\"text\":\"περιορισμός\",\"score\":0,\"status\":\"wrong\"}]', 15, '2025-06-15 21:48:18'),
(12, 202506151750024098, 'ΥΠ16', 7, 2025, '8', '    \r\nΟι πλειάδες μιας σχέσης έχουν ...... σειρά.\r\n  ', 'basics', '[{\"id\":1,\"text\":\"οποιαδήποτε\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"πάντοτε την ίδια\",\"score\":0,\"status\":\"wrong\"},{\"id\":3,\"text\":\"ταξινομημένη\",\"score\":0,\"status\":\"wrong\"},{\"id\":4,\"text\":\"ορισμένη από το χρήστη\",\"score\":5,\"status\":\"wrong\"}]', 15, '2025-06-15 21:48:18'),
(13, 202506151750024098, 'ΥΠ16', 7, 2025, '9', '\r\n  Τι επιστρέφει το ακόλουθο ερώτημα: SELECT * FROM EMPLOYEE WHERE SALARY $<$ SOME (1000,1300,1500);\r\n ', 'sql', '[{\"id\":1,\"text\":\"Τους υπαλλήλους που έχουν μισθό κάτω από 1500.\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"Τους υπαλλήλους που έχουν μισθό κάτω από 1000.\",\"score\":0,\"status\":\"wrong\"},{\"id\":3,\"text\":\"Τους υπαλλήλους που έχουν μισθό κάτω από 1000,1300 ή 1500.\",\"score\":5,\"status\":\"wrong\"},{\"id\":4,\"text\":\"Τους υπαλλήλους που έχουν μισθό πάνω από 1500.\",\"score\":0,\"status\":\"wrong\"}]', 15, '2025-06-15 21:48:18'),
(14, 202506151750024098, 'ΥΠ16', 7, 2025, '10', '\r\nΠώς μπορώ να αλλάξω ένα πεδίο από υποχρεωτικό σε μη υποχρεωτικό;\r\n  ', 'sql', '[{\"id\":1,\"text\":\"Με χρήση της alter table\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"Με χρήση της modify table\",\"score\":0,\"status\":\"wrong\"},{\"id\":3,\"text\":\"Με χρήση της update column\",\"score\":0,\"status\":\"wrong\"},{\"id\":4,\"text\":\"Διαγράφω και ξαναφτιάχνω σωστά τον πίνακα\",\"score\":5,\"status\":\"wrong\"}]', 15, '2025-06-15 21:48:18'),
(15, 202506151750024098, 'ΥΠ16', 7, 2025, '11', '\r\n   Τι κάνω αν θέλω να βρω ποιοι υπάλληλοι έχουν προσληφθεί πριν το διευθυντή του τμήματος στο οποίο εργάζονται;\r\n    ', 'sql', '[{\"id\":1,\"text\":\"Κάνω join τον employee στο deptnumber με ένα view που επιστρέφει την ημερομηνία πρόσληψης του διευθυντή σε κάθε τμήμα.\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"Χρησιμοποιώ nested select για να βρώ την ημερομηνία πρόσληψης του διευθυντή σε κάθε τμήμα.\",\"score\":5,\"status\":\"wrong\"},{\"id\":3,\"text\":\"Ταξινομώ τον πίνακα με αύξουσα σειρά ημερομηνίας πρόσληψης και επιστρέφω τις πρώτες μισές εγγραφές\",\"score\":0,\"status\":\"wrong\"},{\"id\":4,\"text\":\"Ταξινομώ τον πίνακα με αύξουσα σειρά ημερομηνίας πρόσληψης και επιστρέφω τις δεύτερες μισές εγγραφές\",\"score\":0,\"status\":\"wrong\"}]', 15, '2025-06-15 21:48:18'),
(16, 202506151750024098, 'ΥΠ16', 7, 2025, '12', '    \r\n   Πώς μπορώ να ταξινομήσω με φθίνουσα σειρά μισθού τους υπαλλήλους και ταυτόχρονα να εξασφαλίσω ότι θα εμφανίσω μόνο όσους έχουν μισθό;\r\n  ', 'sql', '[{\"id\":1,\"text\":\"...WHERE salary is not null ORDER BY salary DESC;\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"...WHERE salary is not null ORDER BY salary;\",\"score\":5,\"status\":\"wrong\"},{\"id\":3,\"text\":\"...WHERE salary $>$ 0 SORT BY salary DESC;\",\"score\":0,\"status\":\"wrong\"},{\"id\":4,\"text\":\"...HAVING salary ORDER BY salary DESC;\",\"score\":0,\"status\":\"wrong\"}]', 15, '2025-06-15 21:48:18'),
(17, 202506151750024098, 'ΥΠ16', 7, 2025, '13', '    \r\n   Ποιο λάθος έχει το παρακάτω ερώτημα; SELECT sum(salary),lastname FROM EMPLOYEE GROUP BY ssn,lastname;\r\n  ', 'sql', '[{\"id\":1,\"text\":\"Κανένα.\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"Το GROUP BY πρέπει να γίνει στο lastname μόνο\",\"score\":5,\"status\":\"wrong\"},{\"id\":3,\"text\":\"To sum(salary) δεν μπορεί να εμφανίζεται στο SELECT\",\"score\":0,\"status\":\"wrong\"},{\"id\":4,\"text\":\"Πρέπει να χρησιμοποιήσω count(salary) στο SELECT\",\"score\":0,\"status\":\"wrong\"}]', 15, '2025-06-15 21:48:18'),
(18, 202506151750024098, 'ΥΠ16', 7, 2025, '14', '    \r\n   Ποιο λάθος έχει το παρακάτω ερώτημα; SELECT * FROM EMPLOYEE GROUP BY DEPARTMENT HAVING SALARY$>$MAX(SALARY);\r\n  ', 'sql', '[{\"id\":1,\"text\":\"To MAX(SALARY) δεν μπορεί να εφαρμοστεί στο σήμειο αυτό\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"Θέλει WHERE αντί για HAVING\",\"score\":0,\"status\":\"wrong\"},{\"id\":3,\"text\":\"To HAVING θέλει sum(SALARY)\",\"score\":0,\"status\":\"wrong\"},{\"id\":4,\"text\":\"Πρέπει να χρησιμοποιήσω count(*) στο SELECT\",\"score\":0,\"status\":\"wrong\"}]', 10, '2025-06-15 21:48:18'),
(19, 202506151750024098, 'ΥΠ16', 7, 2025, '15', '    \r\n   Πώς διαγράφουμε όλα τα περιεχόμενα του πίνακα EMPLOYEE;\r\n  ', 'sql', '[{\"id\":1,\"text\":\"DELETE FROM EMPLOYEE;\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"DELETE * FROM EMPLOYEE;\",\"score\":0,\"status\":\"wrong\"},{\"id\":3,\"text\":\"FORMAT EMPLOYEE;\",\"score\":0,\"status\":\"wrong\"},{\"id\":4,\"text\":\"DROP TABLE EMPLOYEE;\",\"score\":5,\"status\":\"wrong\"}]', 15, '2025-06-15 21:48:18'),
(20, 202506211750508720, 'ΥΠ23', 6, 2025, '1', '\r\nΠοια από τις παρακάτω μεθόδους χρησιμοποιείται για την εκπαίδευση ενός επιβλεπόμενου μοντέλου μηχανικής μάθησης;\r\n  ', 'ai', '[{\"id\":1,\"text\":\"Χρήση εκπαιδευτικού συνόλου με ετικέτες\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"Αναζήτηση χωρίς δεδομένα\",\"score\":0,\"status\":\"wrong\"},{\"id\":3,\"text\":\"Ενίσχυση τυχαίας αναπαραγωγής\",\"score\":0,\"status\":\"wrong\"},{\"id\":4,\"text\":\"Εξαγωγή χαρακτηριστικών χωρίς επίβλεψη\",\"score\":5,\"status\":\"wrong\"}]', 15, '2025-06-21 12:25:20'),
(21, 202506211750508720, 'ΥΠ23', 6, 2025, '2a', '    \r\nΠοια τεχνική χρησιμοποιείται για την αποφυγή υπερπροσαρμογής (overfitting) σε ένα νευρωνικό δίκτυο;\r\n  ', 'ai', '[{\"id\":1,\"text\":\"Dropout\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"Gradient ascent\",\"score\":0,\"status\":\"wrong\"},{\"id\":3,\"text\":\"Χρήση μεγάλου learning rate\",\"score\":5,\"status\":\"wrong\"},{\"id\":4,\"text\":\"Αύξηση του αριθμού των εποχών\",\"score\":0,\"status\":\"wrong\"}]', 15, '2025-06-21 12:25:20'),
(22, 202506211750508720, 'ΥΠ23', 6, 2025, '2b', '    \r\nΠοια από τις παρακάτω μεθόδους είναι κατάλληλη για μη επιβλεπόμενη μάθηση;\r\n  ', 'ai', '[{\"id\":1,\"text\":\"Ομαδοποίηση (clustering)\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"Λογιστική παλινδρόμηση\",\"score\":0,\"status\":\"wrong\"},{\"id\":3,\"text\":\"Random forest\",\"score\":0,\"status\":\"wrong\"},{\"id\":4,\"text\":\"Γραμμική παλινδρόμηση\",\"score\":5,\"status\":\"wrong\"}]', 15, '2025-06-21 12:25:20'),
(23, 202506211750508720, 'ΥΠ23', 6, 2025, '3', '    \r\nΠοια είναι η βασική διαφορά μεταξύ supervised και unsupervised learning;\r\n  ', 'ai', '[{\"id\":1,\"text\":\"Η ύπαρξη ετικετών στα δεδομένα εκπαίδευσης\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"Η χρήση νευρωνικών δικτύων\",\"score\":0,\"status\":\"wrong\"},{\"id\":3,\"text\":\"Η χρήση μεγάλων συνόλων δεδομένων\",\"score\":0,\"status\":\"wrong\"},{\"id\":4,\"text\":\"Η ανάγκη για προκαταρκτική εξαγωγή χαρακτηριστικών\",\"score\":0,\"status\":\"wrong\"}]', 10, '2025-06-21 12:25:20'),
(24, 202506211750508720, 'ΥΠ23', 6, 2025, '4', '    \r\nΠοια από τις παρακάτω είναι ευρετική μέθοδος αναζήτησης;\r\n  ', 'ai', '[{\"id\":1,\"text\":\"A*\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"Breadth-first search\",\"score\":0,\"status\":\"wrong\"},{\"id\":3,\"text\":\"Depth-first search\",\"score\":0,\"status\":\"wrong\"},{\"id\":4,\"text\":\"Random walk\",\"score\":5,\"status\":\"wrong\"}]', 15, '2025-06-21 12:25:20'),
(25, 202506211750508720, 'ΥΠ23', 6, 2025, '5a', '    \r\nΤι είναι το perceptron;\r\n  ', 'ai', '[{\"id\":1,\"text\":\"Ένα απλό μοντέλο τεχνητού νευρώνα για δυαδική ταξινόμηση\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"Μέθοδος ομαδοποίησης δεδομένων\",\"score\":0,\"status\":\"wrong\"},{\"id\":3,\"text\":\"Αλγόριθμος αναζήτησης σε γράφους\",\"score\":0,\"status\":\"wrong\"},{\"id\":4,\"text\":\"Μέθοδος ενίσχυσης\",\"score\":0,\"status\":\"wrong\"}]', 10, '2025-06-21 12:25:20'),
(26, 202506211750508720, 'ΥΠ23', 6, 2025, '5b', '    \r\nΠοια είναι η βασική λειτουργία της συνάρτησης ενεργοποίησης (activation function) σε ένα νευρωνικό δίκτυο;\r\n  ', 'ai', '[{\"id\":1,\"text\":\"Εισάγει μη γραμμικότητα στο δίκτυο\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"Αυξάνει το learning rate\",\"score\":0,\"status\":\"wrong\"},{\"id\":3,\"text\":\"Μειώνει το overfitting\",\"score\":0,\"status\":\"wrong\"},{\"id\":4,\"text\":\"Κανονικοποιεί τα δεδομένα εισόδου\",\"score\":5,\"status\":\"wrong\"}]', 15, '2025-06-21 12:25:20'),
(27, 202506211750508720, 'ΥΠ23', 6, 2025, '5c', '    \r\nΠοια από τις παρακάτω τεχνικές χρησιμοποιείται για τη μείωση της διάστασης των δεδομένων;\r\n  ', 'ai', '[{\"id\":1,\"text\":\"Principal Component Analysis (PCA)\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"K-means clustering\",\"score\":0,\"status\":\"wrong\"},{\"id\":3,\"text\":\"Decision trees\",\"score\":0,\"status\":\"wrong\"},{\"id\":4,\"text\":\"Gradient boosting\",\"score\":0,\"status\":\"wrong\"}]', 10, '2025-06-21 12:25:20'),
(28, 202506211750508720, 'ΥΠ23', 6, 2025, '6a', '    \r\nΤι είναι το reinforcement learning;\r\n  ', 'ai', '[{\"id\":1,\"text\":\"Μάθηση μέσω αλληλεπίδρασης με το περιβάλλον και λήψης ανταμοιβών ή ποινών\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"Εκπαίδευση με εποπτευόμενα δεδομένα\",\"score\":0,\"status\":\"wrong\"},{\"id\":3,\"text\":\"Ομαδοποίηση χωρίς ετικέτες\",\"score\":5,\"status\":\"wrong\"},{\"id\":4,\"text\":\"Εξαγωγή χαρακτηριστικών από εικόνες\",\"score\":0,\"status\":\"wrong\"}]', 15, '2025-06-21 12:25:20'),
(29, 202506211750508720, 'ΥΠ23', 6, 2025, '6b', '    \r\nΠοια είναι η διαφορά μεταξύ deep learning και παραδοσιακών αλγορίθμων μηχανικής μάθησης;\r\n  ', 'ai', '[{\"id\":1,\"text\":\"Το deep learning χρησιμοποιεί πολυεπίπεδα νευρωνικά δίκτυα για την εξαγωγή χαρακτηριστικών\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"Το deep learning απαιτεί λιγότερα δεδομένα εκπαίδευσης\",\"score\":0,\"status\":\"wrong\"},{\"id\":3,\"text\":\"Οι παραδοσιακοί αλγόριθμοι έχουν πάντα καλύτερη απόδοση\",\"score\":0,\"status\":\"wrong\"},{\"id\":4,\"text\":\"Το deep learning δεν απαιτεί υπολογιστική ισχύ\",\"score\":0,\"status\":\"wrong\"}]', 10, '2025-06-21 12:25:20'),
(30, 202506211750508720, 'ΥΠ23', 6, 2025, '7', '    \r\nΟ όρος ...... αναφέρεται στη διαδικασία κατά την οποία ένα μοντέλο μαθαίνει να γενικεύει από τα δεδομένα εκπαίδευσης.\r\n  ', 'ai', '[{\"id\":1,\"text\":\"εκπαίδευση (training)\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"δοκιμή (testing)\",\"score\":0,\"status\":\"wrong\"},{\"id\":3,\"text\":\"εξαγωγή χαρακτηριστικών\",\"score\":5,\"status\":\"wrong\"},{\"id\":4,\"text\":\"κανονικοποίηση\",\"score\":0,\"status\":\"wrong\"}]', 15, '2025-06-21 12:25:20'),
(31, 202506211750508720, 'ΥΠ23', 6, 2025, '8', '    \r\nΤα δεδομένα εισόδου σε ένα νευρωνικό δίκτυο έχουν ...... διάσταση.\r\n  ', 'ai', '[{\"id\":1,\"text\":\"οποιαδήποτε\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"πάντοτε την ίδια\",\"score\":0,\"status\":\"wrong\"},{\"id\":3,\"text\":\"ταξινομημένη\",\"score\":0,\"status\":\"wrong\"},{\"id\":4,\"text\":\"ορισμένη από το χρήστη\",\"score\":5,\"status\":\"wrong\"}]', 15, '2025-06-21 12:25:20'),
(32, 202506211750508720, 'ΥΠ23', 6, 2025, '9', '\r\nΠοια από τις παρακάτω μεθόδους χρησιμοποιείται για την αξιολόγηση της απόδοσης ενός μοντέλου;\r\n ', 'ai', '[{\"id\":1,\"text\":\"Διασταυρούμενη επικύρωση (cross-validation)\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"Αύξηση του learning rate\",\"score\":0,\"status\":\"wrong\"},{\"id\":3,\"text\":\"Επαναληπτική εκπαίδευση χωρίς επικύρωση\",\"score\":5,\"status\":\"wrong\"},{\"id\":4,\"text\":\"Χρήση τυχαίων δεδομένων\",\"score\":0,\"status\":\"wrong\"}]', 15, '2025-06-21 12:25:20'),
(33, 202506211750508720, 'ΥΠ23', 6, 2025, '10', '\r\nΠώς ονομάζεται το πρόβλημα όπου ένα σύστημα τεχνητής νοημοσύνης αποδίδει υπερβολικά καλά στα δεδομένα εκπαίδευσης αλλά αποτυγχάνει στα νέα δεδομένα;\r\n  ', 'ai', '[{\"id\":1,\"text\":\"Υπερπροσαρμογή (overfitting)\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"Υποπροσαρμογή (underfitting)\",\"score\":0,\"status\":\"wrong\"},{\"id\":3,\"text\":\"Κανονικοποίηση\",\"score\":0,\"status\":\"wrong\"},{\"id\":4,\"text\":\"Ενίσχυση\",\"score\":5,\"status\":\"wrong\"}]', 15, '2025-06-21 12:25:20'),
(34, 202506211750508720, 'ΥΠ23', 6, 2025, '11', '\r\nΠοια είναι η λειτουργία της συνάρτησης κόστους (cost function) σε ένα μοντέλο μηχανικής μάθησης;\r\n    ', 'ai', '[{\"id\":1,\"text\":\"Μετράει τη διαφορά μεταξύ προβλεπόμενων και πραγματικών τιμών\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"Επιταχύνει τη διαδικασία εκπαίδευσης\",\"score\":5,\"status\":\"wrong\"},{\"id\":3,\"text\":\"Κανονικοποιεί τα δεδομένα\",\"score\":0,\"status\":\"wrong\"},{\"id\":4,\"text\":\"Αυξάνει το learning rate\",\"score\":0,\"status\":\"wrong\"}]', 15, '2025-06-21 12:25:20'),
(35, 202506211750508720, 'ΥΠ23', 6, 2025, '12', '    \r\nΠοια από τις παρακάτω τεχνικές χρησιμοποιείται για την επιλογή χαρακτηριστικών (feature selection);\r\n  ', 'ai', '[{\"id\":1,\"text\":\"Αλγόριθμος αναδρομικής εξάλειψης χαρακτηριστικών (RFE)\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"Gradient descent\",\"score\":5,\"status\":\"wrong\"},{\"id\":3,\"text\":\"Random initialization\",\"score\":0,\"status\":\"wrong\"},{\"id\":4,\"text\":\"Batch normalization\",\"score\":0,\"status\":\"wrong\"}]', 15, '2025-06-21 12:25:20'),
(36, 202506211750508720, 'ΥΠ23', 6, 2025, '13', '    \r\nΠοια είναι η βασική διαφορά μεταξύ classification και regression;\r\n  ', 'ai', '[{\"id\":1,\"text\":\"Η classification προβλέπει κατηγορίες, ενώ η regression προβλέπει συνεχείς τιμές\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"Η regression χρησιμοποιεί μόνο νευρωνικά δίκτυα\",\"score\":0,\"status\":\"wrong\"},{\"id\":3,\"text\":\"Η classification απαιτεί περισσότερα δεδομένα\",\"score\":0,\"status\":\"wrong\"},{\"id\":4,\"text\":\"Η regression δεν χρησιμοποιεί ετικέτες\",\"score\":0,\"status\":\"wrong\"}]', 10, '2025-06-21 12:25:20'),
(37, 202506211750508720, 'ΥΠ23', 6, 2025, '14', '    \r\nΠοια από τις παρακάτω μεθόδους χρησιμοποιείται για τη μείωση του overfitting;\r\n  ', 'ai', '[{\"id\":1,\"text\":\"Regularization (L1 ή L2)\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"Αύξηση του αριθμού των παραμέτρων\",\"score\":0,\"status\":\"wrong\"},{\"id\":3,\"text\":\"Χρήση μικρότερου συνόλου εκπαίδευσης\",\"score\":0,\"status\":\"wrong\"},{\"id\":4,\"text\":\"Αφαίρεση dropout\",\"score\":0,\"status\":\"wrong\"}]', 10, '2025-06-21 12:25:20'),
(38, 202506211750508720, 'ΥΠ23', 6, 2025, '15', '    \r\nΠοια είναι η κύρια λειτουργία ενός αλγορίθμου backpropagation;\r\n  ', 'ai', '[{\"id\":1,\"text\":\"Υπολογίζει τα σφάλματα και ενημερώνει τα βάρη σε ένα νευρωνικό δίκτυο\",\"score\":10,\"status\":\"correct\"},{\"id\":2,\"text\":\"Επιλέγει τα χαρακτηριστικά εισόδου\",\"score\":0,\"status\":\"wrong\"},{\"id\":3,\"text\":\"Εκτελεί ομαδοποίηση δεδομένων\",\"score\":0,\"status\":\"wrong\"},{\"id\":4,\"text\":\"Κανονικοποιεί τα δεδομένα εισόδου\",\"score\":5,\"status\":\"wrong\"}]', 15, '2025-06-21 12:25:20');

-- --------------------------------------------------------

--
-- Table structure for table `quizzes`
--

CREATE TABLE `quizzes` (
  `row_id` int(11) NOT NULL,
  `student_id` int(20) NOT NULL,
  `course_id` varchar(11) NOT NULL,
  `date` date NOT NULL,
  `quiz_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`quiz_data`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quizzes`
--

INSERT INTO `quizzes` (`row_id`, `student_id`, `course_id`, `date`, `quiz_data`) VALUES
(38, 20948, 'ΥΠ16', '2025-06-22', '{\"studentId\":\"20948\",\"courseId\":\"ΥΠ16\",\"answers\":{\"1\":10,\"8\":10,\"9\":10,\"11\":10,\"5c\":10},\"percent\":100,\"timestamp\":\"2025-06-22T12:07:00.875Z\"}'),
(39, 20948, 'ΥΠ16', '2025-06-22', '{\"studentId\":\"20948\",\"courseId\":\"ΥΠ16\",\"answers\":{\"1\":0,\"8\":5,\"10\":0,\"11\":0,\"5c\":10},\"percent\":30,\"timestamp\":\"2025-06-22T12:07:31.480Z\"}'),
(40, 20948, 'ΥΠ23', '2025-06-22', '{\"studentId\":\"20948\",\"courseId\":\"ΥΠ23\",\"answers\":{\"4\":10,\"7\":5,\"12\":10,\"2a\":0,\"2b\":10},\"percent\":70,\"timestamp\":\"2025-06-22T12:26:48.715Z\"}'),
(41, 20948, 'ΥΠ16', '2025-06-22', '{\"studentId\":\"20948\",\"courseId\":\"ΥΠ16\",\"answers\":{\"3\":10,\"13\":10,\"14\":10,\"6b\":10,\"5b\":10},\"percent\":100,\"timestamp\":\"2025-06-22T12:27:15.594Z\"}'),
(42, 20025, 'ΥΠ16', '2025-06-22', '{\"studentId\":\"20025\",\"courseId\":\"ΥΠ16\",\"answers\":{\"1\":10,\"7\":0,\"12\":10,\"5c\":10,\"6b\":10},\"percent\":80,\"timestamp\":\"2025-06-22T13:03:34.185Z\"}'),
(43, 20025, 'ΥΠ23', '2025-06-22', '{\"studentId\":\"20025\",\"courseId\":\"ΥΠ23\",\"answers\":{\"4\":0,\"2b\":0,\"6b\":0,\"5c\":0,\"5a\":10},\"percent\":20,\"timestamp\":\"2025-06-22T13:04:21.072Z\"}');

-- --------------------------------------------------------

--
-- Table structure for table `results`
--

CREATE TABLE `results` (
  `row_id` int(11) NOT NULL,
  `student_id` int(20) NOT NULL,
  `course_id` varchar(11) NOT NULL,
  `score` int(11) NOT NULL,
  `pass` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `results`
--

INSERT INTO `results` (`row_id`, `student_id`, `course_id`, `score`, `pass`) VALUES
(19, 20948, 'ΥΠ16', 100, 1),
(21, 20948, 'ΥΠ23', 70, 1),
(23, 20025, 'ΥΠ16', 80, 1),
(24, 20025, 'ΥΠ23', 20, 0);

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_id` int(20) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `password` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_id`, `user_name`, `password`) VALUES
(20025, 'jdoe', 'pwd'),
(20948, 'sdoghri', 'pwd');

-- --------------------------------------------------------

--
-- Table structure for table `students_for_examination`
--

CREATE TABLE `students_for_examination` (
  `id` int(11) NOT NULL,
  `course_id` varchar(11) NOT NULL,
  `file_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `active_students_list` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students_for_examination`
--

INSERT INTO `students_for_examination` (`id`, `course_id`, `file_name`, `active_students_list`) VALUES
(3, 'ΥΠ16', 'students-1.txt', '[\'20948\', \'20925\', \'20023\'];'),
(4, 'ΕΠ19', 'students-1.txt', '[\'20948\', \'20925\', \'20023\'];');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_users`
--
ALTER TABLE `admin_users`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`row_id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`row_id`);

--
-- Indexes for table `quizzes`
--
ALTER TABLE `quizzes`
  ADD PRIMARY KEY (`row_id`);

--
-- Indexes for table `results`
--
ALTER TABLE `results`
  ADD PRIMARY KEY (`row_id`),
  ADD UNIQUE KEY `uniq_student_course` (`student_id`,`course_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD UNIQUE KEY `user_name` (`user_name`);

--
-- Indexes for table `students_for_examination`
--
ALTER TABLE `students_for_examination`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_users`
--
ALTER TABLE `admin_users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10004;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `row_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `row_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `quizzes`
--
ALTER TABLE `quizzes`
  MODIFY `row_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `results`
--
ALTER TABLE `results`
  MODIFY `row_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `students_for_examination`
--
ALTER TABLE `students_for_examination`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
