# $FreeBSD$

PORTNAME=	gitlab
PORTVERSION=	8.1
CATEGORIES=	www

MAINTAINER=	yonas@fizk.net
COMMENT=	Web-based Git repository manager with wiki and issue tracking

LICENSE=	MIT

RUN_DEPENDS=	\
	sudo:${PORTSDIR}/security/sudo \
	bash:${PORTSDIR}/shells/bash \
	cmake:${PORTSDIR}/devel/cmake \
	icu:${PORTSDIR}/devel/icu \
	pkgconf:${PORTSDIR}/devel/pkgconf \
	git:${PORTSDIR}/devel/git \
	nginx:${PORTSDIR}/www/nginx \
	node:${PORTSDIR}/www/node \
	logrotate:${PORTSDIR}/sysutils/logrotate \
	redis:${PORTSDIR}/databases/redis \
	postgresql94:${PORTSDIR}/databases/postgresql94-server \
	postfix:${PORTSDIR}/mail/postfix \
	krb5:${PORTSDIR}/security/krb5

USE_GITHUB=	yes
GH_ACCOUNT=	gitlabhq
GH_PROJECT=	gitlabhq
GH_TAGNAME=	8-1-stable

GITLAB_BASE=	/home/gitlab

PLIST_SUB+=	GITLAB_BASE=${GITLAB_BASE}
SUB_LIST+=	GITLAB_BASE=${GITLAB_BASE}

do-install:
	${MKDIR} ${STAGEDIR}${GITLAB_BASE}/gitlab
	(cd ${WRKSRC} && ${COPYTREE_SHARE} . ${STAGEDIR}${GITLAB_BASE}/gitlab)

.include <bsd.port.mk>
