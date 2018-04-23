<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>GridNewItemRowWeb</title>
    <script type="text/javascript">
        var gridPerformingCallback = false;

        function OnInit(s, e) {
            s.BeginCallback.AddHandler(function (s, e) { gridPerformingCallback = true; });
            s.EndCallback.AddHandler(function (s, e) {
                gridPerformingCallback = false;

                var tbProductName = s.GetEditor('ProductName');
                
                if (tbProductName != null)
                    tbProductName.Focus();
            });
            ASPxClientUtils.AttachEventToElement(s.GetMainElement(), "keydown", function (evt) {
                return OnKeyDown(evt, s);
            });
            s.Focus();
        }

        function OnKeyDown(evt, grid) {
            if (typeof(event) != "undefined" && event != null)
                evt = event;
            if (NeedProcessDocumentKeyDown(evt) && !gridPerformingCallback) {
                if (evt.keyCode == 9 /*Tab key*/) {
                    if (grid.GetFocusedRowIndex() == grid.cpLastVisibleRowIndex)
                        grid.AddNewRow();
                    else
                        grid.SetFocusedRowIndex(grid.GetFocusedRowIndex() + 1);
                    return ASPxClientUtils.PreventEventAndBubble(evt);
                }
            }
        }

        function NeedProcessDocumentKeyDown(evt) {
            var evtSrc = ASPxClientUtils.GetEventSource(evt);
            if (evtSrc.tagName == "INPUT")
                return evtSrc.type != "text" && evtSrc.type != "password";
            else
                return evtSrc.tagName != "TEXTAREA";
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <p>Press the <span style="font-weight: bold; color: #394EA2;">Tab</span> key several times until the New Row is displayed.</p>

        <dx:ASPxGridView ID="ASPxGridView1" runat="server" ClientInstanceName="grid" DataSourceID="AccessDataSource1"
            KeyFieldName="ProductID" AutoGenerateColumns="False" KeyboardSupport="true"
            OnCustomJSProperties="ASPxGridView1_CustomJSProperties">
            
            <SettingsBehavior AllowFocusedRow="true" />
            <SettingsEditing Mode="Inline" NewItemRowPosition="Bottom" />
            <ClientSideEvents Init="OnInit" />

            <Columns>
                <dx:GridViewCommandColumn VisibleIndex="0">
                    <EditButton Visible="True">
                    </EditButton>
                    <DeleteButton Visible="True">
                    </DeleteButton>
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="ProductID" ReadOnly="True" VisibleIndex="1">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ProductName" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="UnitPrice" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="UnitsOnOrder" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>

        <asp:AccessDataSource ID="AccessDataSource1" runat="server" DataFile="~/App_Data/nwind.mdb"
            SelectCommand="SELECT [ProductID], [ProductName], [UnitPrice], [UnitsOnOrder] FROM [Products]"
            DeleteCommand="DELETE FROM [Products] WHERE [ProductID] = ?" InsertCommand="INSERT INTO [Products] ([ProductName], [UnitPrice], [UnitsOnOrder]) VALUES (?, ?, ?)"
            UpdateCommand="UPDATE [Products] SET [ProductName] = ?, [UnitPrice] = ?, [UnitsOnOrder] = ? WHERE [ProductID] = ?">
            <DeleteParameters>
                <asp:Parameter Name="ProductID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="ProductName" Type="String" />
                <asp:Parameter Name="UnitPrice" Type="Decimal" />
                <asp:Parameter Name="UnitsOnOrder" Type="Int16" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="ProductName" Type="String" />
                <asp:Parameter Name="UnitPrice" Type="Decimal" />
                <asp:Parameter Name="UnitsOnOrder" Type="Int16" />
                <asp:Parameter Name="ProductID" Type="Int32" />
            </UpdateParameters>
        </asp:AccessDataSource>
    </div>
    </form>
</body>
</html>
