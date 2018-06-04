<%@ Page Language="C#" runat="server"%>
<%@ Import Namespace = "System.IO" %>

<link rel="stylesheet" type="text/css" href="onememo_css.css"> 
<link href="https://fonts.googleapis.com/css?family=Poiret+One|Questrial" rel="stylesheet">
<script language="C#" runat="server">




void Page_Load()
 {
 
 
 }
 string names;
 double weights;
 double heights;
 string comments;
 
 double BMI;
 string BMItext;
 
 string level;
 
 
 

 string data;
 
 string memo_path = "c:\\home\\ProjectMemo\\BMI\\bmiData.txt";
 
 void Memo_Save(object o, EventArgs e)
 {
  
   names = name.Value;
   comments = comment.Value;
   weights =  Convert.ToDouble(weight.Value);
   heights =  Convert.ToDouble(height.Value);
   
   BMI = Math.Round(weights/((heights/100)*(heights/100)),2);
   
   
   
  if (BMI<18.5)
   level ="underweight";
  else if(BMI >=18.5 && BMI<=24.9)
   level = "normal";
  else if(BMI >=25.0 && BMI<=29.9)
   level = "overweight";
  else
   level = "FAT";
   
   
   data = names + "@"+ System.Convert.ToString(BMI) + "@"+ level + "@" + comments + "@"+ System.DateTime.Now.ToString("f");

  
  
 
 
	using (StreamWriter sw = File.AppendText(memo_path)) 
        {
            sw.WriteLine(data);
            
        }		
		
   

 }

void Memo_Play(object o, EventArgs e){
 
string readText = File.ReadAllText(memo_path);

string[] data_lines = readText.Split(new char[] {'\n'}, StringSplitOptions.RemoveEmptyEntries);

memocount.InnerHtml = "( " + data_lines.Length.ToString() + " )";






StringBuilder datas = new StringBuilder();

datas.Append("<table id=\"result\" width=\'70%\'> ");

for (int i = 0; i < data_lines.Length; i++)
{
   string[] fields = data_lines[i].Split(new string[] {"@"}, StringSplitOptions.None);
   datas.Append("<tr><td width=\"10%\"> <font color=\'#415a63\'>" + "&nbsp;&nbsp;" + fields[0]+  "</td> <td width=\'10%\'> BMI : " + fields[1]+ "</td><td width=\'15%\'> status: " + fields[2] + "</td> <td width =\'40%\'>" + fields[3] + "</td> <td width=\'35%\'> written at " + fields[4] + "</td></tr>");
}

datas.Append("</table>");

output.Text = datas.ToString();


}
 
 
</script>




<form runat="server">

<div id="top">
<table>
ID : <input type="text" id="name" size="10" runat="server">
Weight(kg) : <input type="text" id="weight" size="5" runat="server">
Height(cm) : <input type="text" id="height" size="5" runat="server">
Comment : <input type="text" id="comment" size="50" runat="server">

<tr>
&nbsp;&nbsp;<asp:Button ID="submit" CssClass="btn" Text="Save" runat="server" Onclick="Memo_Save"/>
&nbsp;<asp:Button ID="play" CssClass="btn" Text="Play" runat="server" Onclick="Memo_Play"/>
</tr>

</table>
<hr>
</div>

<p> My ASP Test Board <span id="memocount" runat="server"> </span> </p>

<asp:Literal id="output" runat="server" />
</form>


