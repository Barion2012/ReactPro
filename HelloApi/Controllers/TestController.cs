using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using System.Text.Json;
using System.IO;

namespace HelloApi.Controllers
{
    using Extensions;

    [ApiController]
    [Route("[controller]")]
    public class TestController : ControllerBase
    {

        private readonly ILogger<TestController> _logger;

        public TestController(ILogger<TestController> logger)
        {
            _logger = logger;
        }

        [HttpPost]
        public async Task<IActionResult> Post()
        {
            try
            {
                var req = await Request.Body.JsonDeserializeAsync(new 
                { 
                    UserName=string.Empty
                    , Password=string.Empty
                    , IPs=string.Empty
                });

                var tech = new ICUTechClient();
                await tech.OpenAsync();
                var resp = await tech.LoginAsync(req.UserName, req.Password, req.IPs);
                await tech.CloseAsync();

                return new JsonResult(resp.@return.JsonDeserialize(
                    new { 
                        ResultMessage=string.Empty
                        , FirstName=string.Empty
                    }
                    , new JsonSerializerOptions
                    {
                        PropertyNamingPolicy = null
                    })); 

            }
            catch(Exception ex)
            {
                _logger.LogError(ex.ToString());
                throw;
            }

        }

    }
}
