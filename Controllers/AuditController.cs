using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using System.Collections.Generic;
using System.Linq;
using Microsoft.EntityFrameworkCore;

[Route("api/[controller]")]
[ApiController]

public class AuditController : BaseController
{
    private readonly SqlServerDBContext _context;
    public AuditController(SqlServerDBContext context)
    {
        _context = context;
    }

    // GET: api/Customer
    [HttpGet]
    public ActionResult<IEnumerable<Audit>> GetAudit()
    {
        return _context.Audit.ToList();
    }

    // GET: api/Customer/1
    [HttpGet("{id}")]
    public ActionResult<Audit> GetAudit(int id)
    {
        var audit = _context.Audit
            .Include(a => a.Client) // Include Client related to the Audit
            .FirstOrDefault(a => a.Id == id);

        if (audit == null)
        {
            return NotFound();
        }else{
            var infosAudit =  audit.Id + " !,! " + audit.CreatedDate.ToString() + "!,!" + audit.SubmittedDate.ToString()+ "!,!" + audit.Client.Name;
            return Ok(infosAudit);
        }

    }

    // POST: api/Customer
    [HttpPost("CreateAudit")]
    public ActionResult<Audit> CreateAudit(int userId, int clientId)
    {
        var user = _context.User.Find(userId);
        if (user == null)
            return NotFound("User not found");

        var client = _context.Client.Find(clientId);
        if (client == null)
            return NotFound("Client not found");

        DateTime current = DateTime.Now;

        var audit = new Audit
        {
            CreatedDate = current,
            SubmittedDate = null,
            ClientId = clientId
        };

        var userAudit = new UserAudit
        {
            UserId = userId
        };

        audit.UserAudits.Add(userAudit);
        _context.Audit.Add(audit);
        _context.SaveChanges();

        foreach (var question in _context.Question.Where(q => q.Visible == true).ToList())
        {
            var auditQuestion = new AuditQuestion
            {
                AuditId= audit.Id,
                QuestionId = question.Id
            };

            _context.AuditQuestion.Add(auditQuestion);
        }

        _context.SaveChanges();
        return Ok("Audit créé");
    }
    // GET: api/Customer/1
    [HttpGet("GetLastAudit/{userId}")]
    public ActionResult<string> GetLastAuditDate(int userId)
    {
        var audits = _context.Audit.Where(a => a.ClientId == userId).ToList();
        if (!audits.Any())
        {
            return "Client non audité";
        }

        var lastUserAudit = audits
            .Where(a => a.SubmittedDate < DateTime.Today)
            .OrderByDescending(a => a.SubmittedDate)
            .FirstOrDefault();
        if (lastUserAudit == null)
        {
            return "Client non audité";
        }

        return Ok(lastUserAudit.SubmittedDate.ToString());
    }
    
    // GET: api/Customer/1
    [HttpGet("GetNBjoursSansAudit/{userId}")]
    public ActionResult<string> GetNBjoursSansAudit(int userId)
    {
        var audits = _context.Audit.Where(a => a.ClientId == userId).ToList();
        if (!audits.Any())
        {
            return "Client non audité";
        }

        var lastUserAudit = audits
            .Where(a => a.SubmittedDate < DateTime.Today)
            .OrderByDescending(a => a.SubmittedDate)
            .FirstOrDefault();
        if (lastUserAudit == null)
        {
            return "Client non audité";
        }
        if (lastUserAudit.SubmittedDate == null)
        {
            return "Client non audité";
        }
        var nbJours = Math.Round((DateTime.Now - lastUserAudit.SubmittedDate.Value).TotalDays);

        return Ok(nbJours.ToString());
    }
}
