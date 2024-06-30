using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using System.Collections.Generic;
using System.Linq;
using Microsoft.EntityFrameworkCore;

[Route("api/[controller]")]
[ApiController]
public class QuestionController : BaseController
{
    private readonly SqlServerDBContext _context;
    public QuestionController(SqlServerDBContext context)
    {
        _context = context;
    }

    // GET: api/Customer
    [HttpGet]
    public ActionResult<IEnumerable<Question>> GetQuestion()
    {
        return _context.Question
            .OrderBy(question => question.TargetId)
            .ThenBy(question => question.ThemeId)
            .ThenBy(question => question.RequiredLevelId)
            .Include(question => question.Theme)
            .Include(question => question.Target)
            .Include(question => question.RequiredLevel)
            .ToList();
    }
    // PUT: api/Customer/1
    [HttpPut("ModifierVisibilité/{id}")]
    public IActionResult UpdateQuestionVisibility(int id)
    {
        var question = _context.Question.Find(id);
        if (question == null)
        {
            return NotFound();
        }

        question.Visible = !question.Visible; // Assuming Visibility is a boolean property

        _context.Entry(question).State = EntityState.Modified;
        _context.SaveChanges();
        return NoContent();
    }

    // POST: api/AddCustomer
    [HttpPost("AddQuestion")]
    public ActionResult<Question> CreateQuestion(string questionLabel, string ThemeLabel, string cible , string requiredLevel)
    {
        if (string.IsNullOrEmpty(questionLabel) || string.IsNullOrEmpty(ThemeLabel))
        {
            return BadRequest();
        }

        // Vérifiez et créez le Theme si nécessaire
        var existingTheme = _context.Theme.FirstOrDefault(g => g.Label == ThemeLabel);
        if (existingTheme == null)
        {
            existingTheme = new Theme { Label = ThemeLabel };
            _context.Theme.Add(existingTheme);
            _context.SaveChanges();
        }

        // Vérifiez et créez la Target si nécessaire
        var existingTarget = _context.Target.FirstOrDefault(g => g.Label == cible);
        if (existingTarget == null)
        {
            existingTarget = new Target { Label = cible };
            _context.Target.Add(existingTarget);
            _context.SaveChanges();
        }

        // Vérifiez et créez le RequiredLevel si nécessaire
        var existingRequiredLevel = _context.RequiredLevel.FirstOrDefault(g => g.Label == requiredLevel);
        if (existingRequiredLevel == null)
        {
            existingRequiredLevel = new RequiredLevel { Label = requiredLevel };
            _context.RequiredLevel.Add(existingRequiredLevel);
            _context.SaveChanges();
        }

        // Créez une nouvelle question associée au Theme, Target, et RequiredLevel
        var newQuestion = new Question 
        { 
            Label = questionLabel, 
            Visible = true,  
            ThemeId = existingTheme.Id, 
            TargetId = existingTarget.Id, 
            RequiredLevelId = existingRequiredLevel.Id
        };
        _context.Question.Add(newQuestion);
        _context.SaveChanges();
        return Ok("Question ajoutée avec succès!");
    }

}
