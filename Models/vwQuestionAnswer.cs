using System.ComponentModel.DataAnnotations;

public class vwQuestionAnswer {
    public string? Label { get; set; }
    public string? AnswerText { get; set; }
    public int? Rating { get; set; }
    public int AuditId { get; set; }
}