create or replace view aggJoin3626205449340973229 as (
with aggView5563601133353073996 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView5563601133353073996 where mc.company_id=aggView5563601133353073996.v20);
create or replace view aggJoin4384843189107801209 as (
with aggView7397875961344796686 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView7397875961344796686 where mk.keyword_id=aggView7397875961344796686.v25);
create or replace view aggJoin419499183097464565 as (
with aggView8245017564248803913 as (select id as v3 from title as t)
select v3 from aggJoin4384843189107801209 join aggView8245017564248803913 using(v3));
create or replace view aggJoin935309968655884891 as (
with aggView162379907603403473 as (select v3 from aggJoin419499183097464565 group by v3)
select v3 from aggJoin3626205449340973229 join aggView162379907603403473 using(v3));
create or replace view aggJoin4054436308343794510 as (
with aggView2727417417459795470 as (select v3 from aggJoin935309968655884891 group by v3)
select person_id as v26 from cast_info as ci, aggView2727417417459795470 where ci.movie_id=aggView2727417417459795470.v3);
create or replace view aggJoin4691997964631563728 as (
with aggView4341343241727358466 as (select v26 from aggJoin4054436308343794510 group by v26)
select name as v27 from name as n, aggView4341343241727358466 where n.id=aggView4341343241727358466.v26 and name LIKE 'B%');
create or replace view aggView6387780536322902910 as select v27 from aggJoin4691997964631563728 group by v27;
select MIN(v27) as v47 from aggView6387780536322902910;
