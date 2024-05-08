CREATE PROCEDURE [dbo].[SSISTeamsNotificationError]
AS
BEGIN
    DECLARE @url NVARCHAR(500), @body NVARCHAR(MAX), @response INT;
 
    -- Set the Teams webhook URL
    SET @url = 'https://northerndata.webhook.office.com/webhookb2/8548e769-6611-4616-8298-fd3a7dfad168@174c7352-9c5c-4558-b848-be140b444e7d/IncomingWebhook/62741d1a60814bb2a0122cbbeb9abe8b/bf93059d-2b41-4059-afb0-0550a892861c';
 
    -- JSON payload for the notification
    SET @body = '{"@type": "MessageCard","@context": "http://schema.org/extensions","themeColor": "0078D7","summary": "SSIS package has Failed","sections": [{"activityTitle": "SSIS package has Failed","activitySubtitle": "Please visit link to view errors","activityImage": "https://imageurl.com/image.jpg","text": "[View Error Dashboard](http://localhost:5601/app/r/s/GQPqG)"}]}';
	    -- Send the POST request
    EXEC sp_OACreate 'MSXML2.ServerXMLHTTP', @response OUT;
    EXEC sp_OAMethod @response, 'Open', NULL, 'POST', @url, 'false';
    EXEC sp_OAMethod @response, 'setRequestHeader', NULL, 'Content-Type', 'application/json';
    EXEC sp_OAMethod @response, 'send', NULL, @body;
    EXEC sp_OADestroy @response;
END;
GO