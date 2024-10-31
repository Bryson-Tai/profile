
    // Type Writer for Job Position
    document.addEventListener('DOMContentLoaded', () => {
        new Typed('#job-position', {
            strings: ['Junior DevOps Engineer', 'Web Developer'],
            typeSpeed: 80,
            backSpeed: 50,
            startDelay: 200,
            backDelay: 2000,
            loop: true,
            showCursor: false,
        });

        //Calculate Age Dynamically
        document.getElementById('age_count').textContent = new Date().getFullYear() - 1996;
        document.getElementById('coding_year').textContent = new Date().getFullYear() - 2019;
        addProjects();
        addTechnology();
        addKnowledge();
        addSoftSkills();
        addLanguages();
    });

    // Resume Progress Bar Animation
    document.getElementById("container").addEventListener('scroll', (c) => {
        let progressBarStyleExist = document.querySelectorAll('.progress_bar')[0].hasAttribute('style');
        let outerCircleStyleExist = document.querySelectorAll('.outer-circle')[0].hasAttribute('style');

        if (c.target.scrollTop >= 600 && !progressBarStyleExist) {
            incrementProgress()
        }

        if (c.target.scrollTop >= 900 && !outerCircleStyleExist) {
            incrementCircle()
        }
    })

    // Navigation Bar Animation
    document.querySelectorAll('header nav ul li a').forEach((link) => {
        link.addEventListener('click', (e) => {
            e.preventDefault()

            // Remove all active class 
            document.querySelectorAll('header nav ul').forEach((ul) => {
                ul.querySelectorAll('li a').forEach((link) => {
                    link.classList.remove('font-orange')
                })
            })

            //Add active class to current link
            link.classList.add('font-orange')

            const sections = document.querySelectorAll("section")
            let id = link.getAttribute("id").split("-tab")[0]

            sections.forEach(sect => {
                let sectionSubstr = sect.classList.value.split("_sect")[0]

                // Remove progress bar and circle animation when not in resume section
                if (!sectionSubstr.includes("resume")){
                    let progressBar = document.querySelectorAll('.progress_bar');
                    let outerCircle = document.querySelectorAll('.outer-circle');

                    for (let i = 0; i < progressBar.length; i++) {
                        progressBar[i].removeAttribute("style");
                    }
                    for (let i = 0; i < outerCircle.length; i++) {
                        outerCircle[i].removeAttribute("style");
                    }
                }

                // Remove fade animation when not in section
                if (sectionSubstr.includes(id)){
                    sect.classList.remove("fadeToLeft")
                    sect.classList.add("fadeToRight")
                    setTimeout(() => {
                        sect.setAttribute("style", "display:block;")
                    }, 400)
                }else{
                    sect.classList.remove("fadeToRight")
                    sect.classList.add("fadeToLeft")
                    setTimeout(() => {
                        sect.setAttribute("style", "display:none;")
                    }, 400)
                }
            })
        })
    })

    document.getElementById("cv-download-btn").addEventListener("click", () =>{
        alert("This feature is still under development. Please check back later 😄");
    })

    document.getElementById("send-email-btn").addEventListener("click", () =>{
        alert("This feature is still under development. Please check back later 😄");
    })

    function incrementCircle() {
        let outerCircle = document.querySelectorAll('.outer-circle');

        outerCircle.forEach((circle) => {
            let progressValue = 0;
            let span = circle.querySelector('span')
            let percentageValue = span.textContent
            let afterSubStr = percentageValue.substring(0, 2);

            setInterval(() => {
                if (progressValue < afterSubStr) {
                    progressValue++
                    circle.style.background = `conic-gradient(
                        #5e3f7b ${progressValue}%, 
                        #fff ${progressValue}% 100%
                    )`
                } else {
                    clearInterval()
                }
            }, 10)
        })
    }

    function incrementProgress() {
        let progressBox = document.querySelectorAll('.progress_box')
        progressBox.forEach((box) => {
            let progressPercentage = box.querySelector('.progress_title h3:nth-child(2)').textContent.substring(0, 2)
            let progressBar = box.querySelector('.progress_bar')
            let progressValue = 0;

            setInterval(() => {
                if (progressValue < progressPercentage) {
                    progressValue++
                    progressBar.style.width = `${progressValue}%`
                } else {
                    clearInterval()
                }
            }, 15)
        })
    }
