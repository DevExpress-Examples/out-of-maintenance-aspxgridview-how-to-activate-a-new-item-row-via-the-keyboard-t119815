using System;
using DevExpress.Web.ASPxGridView;

public partial class _Default : System.Web.UI.Page {
    protected void Page_Init(object sender, EventArgs e) {

    }

    protected void ASPxGridView1_CustomJSProperties(object sender, ASPxGridViewClientJSPropertiesEventArgs e) {
        e.Properties["cpLastVisibleRowIndex"] = (ASPxGridView1.PageIndex == -1) ? ASPxGridView1.VisibleRowCount : 
            Math.Min(ASPxGridView1.SettingsPager.PageSize * (ASPxGridView1.PageIndex + 1), ASPxGridView1.VisibleRowCount) - 1;
    }
}