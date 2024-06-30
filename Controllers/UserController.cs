using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using System.Collections.Generic;
using System.Linq;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using System;
using Microsoft.Extensions.Configuration;
using BCrypt.Net; 

[Route("api/[controller]")]
[ApiController]

public class UserController : BaseController
{
    private readonly SqlServerDBContext _context;
    private readonly IConfiguration _configuration; // Add this line

    public UserController(SqlServerDBContext context, IConfiguration configuration) // Add IConfiguration parameter
    {
        _context = context;
        _configuration = configuration; // Initialize _configuration field
    }

    // GET: api/getAllUsers
    [HttpGet("getAllUsers")]
    [AllowAnonymous]
    public IActionResult GetAllUsers()
    {
        return Ok(_context.User.ToList());
    }

/*     // POST: api/register
    [HttpPost("register")]
    [AllowAnonymous]
    public IActionResult Register(User user)
    {
        if (user == null || user.Email == null || user.Password == null)
        {
            return BadRequest();
        }
        _context.User.Add(user);
        _context.SaveChanges();
        return CreatedAtAction(nameof(GetAllUsers), new { id = user.Id }, user);
    }

    // POST: api/login
    [HttpPost("login")]
    [AllowAnonymous]
    public IActionResult Login(String Password, String Email)
    {
        if (Email == null || Password == null)
        {
            return BadRequest("Email or Password is invalid");
        }
        if(Email =! User.Email || Password =! User.Password)
        {
            return BadRequest("Email or Password is invalid");
        }
        var secretKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["Jwt:SecretKey"]));
        var signinCredentials = new SigningCredentials(secretKey, SecurityAlgorithms.HmacSha256);
        var claims = new List<Claim>
        {
            new Claim(ClaimTypes.Email, Email)
        };
        var tokeOptions = new JwtSecurityToken(
            issuer: _configuration["Jwt:Issuer"],
            audience: _configuration["Jwt:Audience"],
            claims: claims,
            expires: DateTime.Now.AddMinutes(5),
            signingCredentials: signinCredentials
        );
        var tokenString = new JwtSecurityTokenHandler().WriteToken(tokeOptions);
        return Ok(new { Token = tokenString });
    } */

   
    
}
