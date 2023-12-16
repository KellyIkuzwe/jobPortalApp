package com.jobportal.controller;

import java.sql.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.jobportal.model.AddJob;
import com.jobportal.services.AddJobService;

@RestController
@RequestMapping("/Recruiter")
public class RecruiterRestController {

	@Autowired
	private AddJobService addJobService;

	@PostMapping("/saveJob")
	public AddJob addJob(@RequestParam("companyName") String companyName,
						 @RequestParam("jobSkills") String jobSkills,
						 @RequestParam("date") Date date,
						 @RequestParam("city") String city,
						 @RequestParam("description") String description) {
		AddJob addjob = new AddJob();
		addjob.setCompanyName(companyName);
		addjob.setJobSkills(jobSkills);
		addjob.setDate(date);
		addjob.setCity(city);
		addjob.setDescription(description);
		addJobService.saveJob(addjob);
		return addjob;
	}

	@PostMapping("/updateJob")
	public AddJob updateJob(@RequestBody AddJob addjob) {
		addJobService.saveJob(addjob);
		return addjob;
	}

	@GetMapping("/jobList")
	public List<AddJob> getJobs(@RequestParam(required = false) String keyword) {
		if (keyword == null) {
			return addJobService.getJobList();
		} else {
			return addJobService.getjobByKeyword(keyword);
		}
	}

	@DeleteMapping("/deleteJob/{id}")
	public void deleteJobById(@PathVariable int id) {
		addJobService.deleteJobById(id);
	}
}
