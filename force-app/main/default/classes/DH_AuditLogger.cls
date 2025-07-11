/**
* @File Name : DH_AuditLogger.cls
* @Description :
* @Author :
* @Last Modified By :
* @Last Modified On : July 9, 2025
* @Modification Log :
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | July 9, 2025 |   | Initial Version
**/

public with sharing class DH_AuditLogger {
    /**
     * Logs a field change as a human-readable comment on the ticket.
     * 
     * @param ticketId The Salesforce Ticket Id
     * @param fieldName The name of the field changed (e.g., 'Description')
     * @param oldValue The old value (before change)
     * @param newValue The new value (after change)
     * @param source The source system ('Salesforce' or 'Jira')
     * @param changedBy Who made the change (string, optional)
     */
    public static void logFieldChange(
        Id ticketId,
        String fieldName,
        String oldValue,
        String newValue,
        String source,
        String changedBy
    ) {
        String msg = '[' + source + '] ' + (changedBy != null ? changedBy + ' updated ' : '')
                   + fieldName + '\n'
                   + 'OLD: "' + (oldValue == null ? '' : oldValue) + '"\n'
                   + 'NEW: "' + (newValue == null ? '' : newValue) + '"\n'
                   + 'Time: ' + String.valueOf(Datetime.now());
        insert new DH_Ticket_Comment__c(
            TicketId__c = ticketId,
            BodyTxt__c = msg,
            SourcePk__c = source
        );
    }
}