let firstButton = document.getElementById("first-button");
let linee = document.getElementsByClassName("other-line");
let littleLinks = document.getElementsByClassName("little-link");
let	containers = document.getElementsByClassName("container-div");
let	containerIndex = 0;
let	zIndex = 2;

firstButton.addEventListener("click", moveLines, {capture: true});
firstButton.addEventListener("mouseenter", toBlue, {capture: true});
firstButton.addEventListener("mouseleave", toWhite, {capture: true});

function	moveLines()
{
	firstButton.removeEventListener("click", moveLines, {capture: true});
	firstButton.removeEventListener("mouseenter", toBlue, {capture: true});
	firstButton.removeEventListener("mouseleave", toWhite, {capture: true});
	for (let i = 0; i < linee.length; i++) {
		let linea = linee[i];
		linea.style.animationPlayState = "running";
	}
	for (let i = 0; i < littleLinks.length; i++) {
		let link = littleLinks[i];
		link.style.animationPlayState = "running";
	}
	openContainer();
}

function	toBlue()
{
	firstButton.style.animationName = "central-box-to-blue";
	firstButton.style.animationPlayState = "running";
}

function	toWhite()
{
	firstButton.style.animationName = "central-box-to-white";
	firstButton.style.animationPlayState = "running";
}

function	openContainer()
{
	let actualContainer = containers[containerIndex++];
	let	childs;

	actualContainer.style.zIndex = zIndex++;
	actualContainer.style.animationPlayState = "running";
	childs = actualContainer.children;
	for (let i = 0; i < childs.length; i++)
		childs[i].style.animationPlayState = "running";
	if (containerIndex === 3)
		containers[2].children[0].children[0].style.animationPlayState = "running";
	if (containerIndex < containers.length)
		actualContainer.addEventListener("animationend", prepareNextContainer, {capture: true});
	actualContainer.removeEventListener("click", openContainer, {capture: true});
}

function	prepareNextContainer()
{
	containers[containerIndex - 1].addEventListener("click", openContainer, {capture: true});
}
