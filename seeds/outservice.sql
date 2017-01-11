UPDATE deployments t
SET outservice = '2006-05-27'
FROM devices
WHERE t.device_id = devices.id AND devices.serial_num = 'GSM01438';

UPDATE deployments t
SET outservice = '2006-10-28'
FROM devices
WHERE t.device_id = devices.id AND devices.serial_num = 'GSM01508';

UPDATE deployments t
SET outservice = '2007-02-09'
FROM devices
WHERE t.device_id = devices.id AND devices.serial_num = 'GSM01511';

UPDATE deployments t
SET outservice = '2006-10-29'
FROM devices
WHERE t.device_id = devices.id AND devices.serial_num = 'GSM01512';

UPDATE deployments t
SET outservice = '2008-03-15'
FROM devices
WHERE t.device_id = devices.id AND devices.serial_num = 'GSM02927';
