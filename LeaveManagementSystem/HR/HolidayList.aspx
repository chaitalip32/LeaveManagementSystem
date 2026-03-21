<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="HolidayList.aspx.cs" Inherits="LeaveManagementSystem.HR.HolidayList" %>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
    <style>
       
        .page-content{
            padding:20px;
        }

        .table-container{
            background:#ffffff;
            padding:20px;
            border-radius:10px;
            box-shadow:0 4px 12px rgba(0,0,0,0.05);
        }

        .table{
            margin:0;
        }

        .table th{
             background:#343a40;
             color:white;
             text-align:center;
             padding:12px;
        }

        .table td{
            padding:12px;
            vertical-align: middle;
        }

        .table tbody tr{
            border-bottom:1px solid #e5e7eb;
        }

        .table tbody tr:hover{
            background:#f9fafb;
        }

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-content mt-3">

         <h4 class="mb-4 fw-semibold text-center">Leave History</h4>
    <div class="table-responsive">
        <asp:GridView ID="gvHolidayList" runat="server" AutoGenerateColumns="false"
        CssClass="table table-bordered table-hover" OnRowCommand="gvHolidayList_RowCommand">
        <Columns>

            <asp:BoundField DataField="HolidayId" HeaderText="ID" Visible="false"/>
            
            <asp:BoundField DataField="HolidayName" HeaderText="Holiday"/>

            <asp:BoundField DataField="HolidayDate" HeaderText="Holiday Date" DataFormatString="{0:dd-MM-yyyy}"/>
        
            <asp:BoundField DataField="Description" HeaderText="Description"/>

            <asp:BoundField DataField="Status" HeaderText="Status"/>
         
            <asp:TemplateField HeaderText="Action">
                <ItemTemplate>
                    <asp:LinkButton
                        ID="btnEdit"
                        runat="server"
                        Text="Edit"
                        CssClass="btn btn-sm btn-primary"
                        CommandName="EditHoliday"
                        CommandArgument='<%# Eval("HolidayId") %>'
                        >
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>
    </asp:GridView>
    </div>
        </div>
</asp:Content>
