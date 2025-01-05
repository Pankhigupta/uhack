const translation = {
    en:{
        selct :"YatriPath",
        title :"About Us",
        pargr :"Welcome to the Indian Railways kiosk. Use the options below for further navigation:",
        s2:"NO LIVE UPDATES YET!!!",
        s3:"Hello Passenger",
        s4:"QR for kiosk Location",
        s5:"YatriPath Services",
        s6:"Show QR Code",
        s7:"3D View",
        s8:"Pathfinding",
        s9:"Map View",
        getdirections:"Get Directions",
        Others:"Others",
        modaltitle:"Select View",
        



    },
    hin:{
        selct:"यात्रीपथ",
        title:"हमारे बारे में",
        pargr:"भारतीय रेलवे कियोस्क में आपका स्वागत है। आगे नेविगेशन के लिए नीचे दिए गए विकल्पों का उपयोग करें:",
        s2:"अभी तक कोई लाइव अपडेट नहीं!!!",
        s3:"नमस्ते यात्री",
        s4:"कियोस्क स्थान के लिए क्यूआर",
        s5:"यात्रीपथ सेवाएँ",
        s6:"क्यूआर",
        s7:"3D में देखें",
        s8:"पथ प्राप्त करें",
        s9:"मानचित्र देखें",
        getdirections:"दिशा - निर्देश",
        Others:"अन्य",
        modaltitle:"दृश्य का चयन करें",
        
        

    }
}  

const languageSelectop =  document.querySelector("select");
let h1 = document.getElementById("h1");
let title = document.getElementById("title");
let pargr = document.getElementById("pargr");
let s2 = document.getElementById("s2");
let s3 = document.getElementById("s3");
let s4 = document.getElementById("s4");
let s5 = document.getElementById("s5");
let s6 = document.getElementById("s6");
let s7 = document.getElementById("s7");
let s8 = document.getElementById("s8");

let getdirections = document.getElementById("getdirections");
let Others = document.getElementById("Others");
let modaltitle = document.getElementById("modaltitle");

languageSelectop.addEventListener("change",(event) => {
    setLanguage(event.target.value)
})

const setLanguage = (language) =>{
    if(language == "hin"){
        h1.innerText = translation.hin.selct;
        title.innerText = translation.hin.title;
        pargr.innerText = translation.hin.pargr;
        s2.innerText = translation.hin.s2;
        s3.innerText = translation.hin.s3;
        s4.innerText = translation.hin.s4;
        s5.innerText = translation.hin.s5;
        s6.innerText = translation.hin.s6;
        s7.innerText = translation.hin.s7;
        s8.innerText = translation.hin.s8;
        s9.innerText = translation.hin.s9;
       
        modaltitle.innerText = translation.hin.modaltitle;
        
        getdirections.innerText = translation.hin.getdirections;
        Others.innerText = translation.hin.Others;

    }
    else if(language == "en"){
        h1.innerText = translation.en.selct;
        title.innerText = translation.en.title;
        pargr.innerText = translation.en.pargr;
        s2.innerText = translation.en.s2;
        s3.innerText = translation.en.s3;
        s4.innerText = translation.en.s4;
        s5.innerText = translation.en.s5;
        s6.innerText = translation.en.s6;
        s7.innerText = translation.en.s7;
        s8.innerText = translation.en.s8;
        s9.innerText = translation.en.s9;
        
        modaltitle.innerText = translation.en.modaltitle;
        getdirections.innerText = translation.en.getdirections;
        Others.innerText = translation.en.Others;
    }
}

document.getElementById("show-qr").addEventListener("click", function() {
    const qrImage = document.querySelector(".qr-img");
    qrImage.style.display = "block";  // Display the QR code
});
