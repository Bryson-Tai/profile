async function addProjects() {
    const jsonData = await fetch("../data/projects.json")
        .then(resp => resp.json());
    
    const section = document.getElementById("project_sect")
    var htmlTemplate = "";
    
    jsonData.forEach(e => {
        var tagsHTML = "";

        e.tags.forEach(tag => {
            tagsHTML += `<span class="${tag.css_class}">${tag.name}</span>`
        })

        htmlTemplate += `
            <div class="project_wrap">
                <a href="${e.link}" target="_blank">
                    <div class="projects">
                        <div class="project-links">
                            <span>${e.name}</span><span>> > ></span>
                        </div>
                        <div class="tags">
                            ${tagsHTML}
                        </div>
                        <div class="desc">
                            <p>
                                ${e.description}
                            </p>
                        </div>
                    </div>
                </a>
            </div>
        `
    });

    section.innerHTML += htmlTemplate
}

async function addTechnology() {
    const jsonData = await fetch("../data/abilities.json")
        .then(resp => resp.json());
    
    const section = document.getElementById("technology")
    var htmlTemplate = "";
    
    jsonData["technology"].forEach(e => {
        htmlTemplate += `
            <div class="progress_box">
                <div class="progress_title">
                    <h3>${e.name}</h3>
                    <h3>${e.percent}%</h3>
                </div>
                <div class="progress">
                    <div class="progress_bar">
                    </div>
                </div>
            </div>
        `
    });

    section.innerHTML += htmlTemplate
}

async function addKnowledge() {
    const jsonData = await fetch("../data/abilities.json")
        .then(resp => resp.json());
    
    const section = document.querySelector("#knowledge > ul")
    var htmlTemplate = "";
    
    jsonData["knowledge"].forEach(e => {
        htmlTemplate += `
            <div class="li_i_wrap">
                <i class="fa-solid fa-check"></i>
                <li>${e.name}</li>
            </div>
        `
    });

    section.innerHTML += htmlTemplate
}

async function addSoftSkills() {
    const jsonData = await fetch("../data/abilities.json")
        .then(resp => resp.json());
    
    const section = document.querySelector("#soft_skills > ul")
    var htmlTemplate = "";
    
    jsonData["soft_skills"].forEach(e => {
        var tagsHTML = "";
        for (let i = 0; i < 10; i++) {
            if (i < e.circleOf10) {
                tagsHTML += `<i class="fa-solid fa-circle"></i>`
            } else {
                tagsHTML += `<i class="fa-solid fa-circle grey-btn"></i>`
            }
        }

        htmlTemplate += `
            <div class="li_i_wrap">
                <li>${e.name}</li>
                <div class="progress_btns_wrap">
                    ${tagsHTML}
                </div>
            </div>
        `
    });

    section.innerHTML += htmlTemplate
}

async function addLanguages() {
    const jsonData = await fetch("../data/abilities.json")
        .then(resp => resp.json());
    
    const languageArr = jsonData["languages"];
    const upperWrap = document.getElementById("upper-wrap")
    const bottomWrap = document.getElementById("bottom-wrap")
    
    for (let i = 0; i < languageArr.length; i++) {
        const languageName = languageArr[i].name
        const languagePercent = languageArr[i].percent

        if (i % 2 == 0) {
            upperWrap.innerHTML += `
            <div class="circle-wrap">
                <div class="outer-circle">
                    <div class="inner-circle">
                        <span>${languagePercent}%</span>
                    </div>
                </div>
                <h2>${languageName}</h2>
            </div>
        `
        } else {
            bottomWrap.innerHTML += `
            <div class="circle-wrap">
                <div class="outer-circle">
                    <div class="inner-circle">
                        <span>${languagePercent}%</span>
                    </div>
                </div>
                <h2>${languageName}</h2>
            </div>
        `
        }
    }
}