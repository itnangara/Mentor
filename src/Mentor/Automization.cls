Class Mentor.Automization Extends %Persistent
{
    /// Property Automization
    ClassMethod PropertyAutomization() As %Status
    {
        INSERT INTO LSP_Events_Data.GebeurtenisAbonnement (Active, GeldigTot, HashValueUniqueSubscription, ApplicationId_Extension, ApplicationId_Root, DataCategorieCode_Code, DataCategorieCode_CodeSystem, EigenaarCode_Code, EigenaarCode_CodeSystem, EigenaarId_Extension, EigenaarId_Root, EventCode_Code, EventCode_CodeSystem, OrganisationId_Extension, OrganisationId_Root, PatientId_Extension, PatientId_Root, SubscriptionId_Extension, SubscriptionId_Root)
        VALUES(0,'52221','52202','5222','623112','623122','623222','623223','623233','623333','678334','678344','678345','678355','678366','678333','678377','678388','678399')
        
        Return 1
    }
}