create or replace view aggJoin5964777855107422006 as (
with aggView1783764932054665860 as (select id as v53, title as v66 from title as t where production_year>2000)
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v66 from cast_info as ci, aggView1783764932054665860 where ci.movie_id=aggView1783764932054665860.v53 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin4747108441708177889 as (
with aggView3123850135433517419 as (select id as v51 from role_type as rt where role= 'actress')
select v42, v53, v9, v20, v66 from aggJoin5964777855107422006 join aggView3123850135433517419 using(v51));
create or replace view aggJoin7209395098787936049 as (
with aggView6330940642041885450 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView6330940642041885450 where mc.company_id=aggView6330940642041885450.v23);
create or replace view aggJoin661254927882364150 as (
with aggView3338766800539994608 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53 from movie_info as mi, aggView3338766800539994608 where mi.info_type_id=aggView3338766800539994608.v30);
create or replace view aggJoin3129904933970195924 as (
with aggView4037656389582643797 as (select id as v9 from char_name as chn)
select v42, v53, v20, v66 from aggJoin4747108441708177889 join aggView4037656389582643797 using(v9));
create or replace view aggJoin7013666279249001714 as (
with aggView3130585401984043986 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView3130585401984043986 where n.id=aggView3130585401984043986.v42 and gender= 'f');
create or replace view aggJoin2357081762137056003 as (
with aggView2202702304588746667 as (select v42, MIN(v43) as v65 from aggJoin7013666279249001714 group by v42)
select v53, v20, v66 as v66, v65 from aggJoin3129904933970195924 join aggView2202702304588746667 using(v42));
create or replace view aggJoin8481144100315516292 as (
with aggView6258996481854352722 as (select v53, MIN(v66) as v66, MIN(v65) as v65 from aggJoin2357081762137056003 group by v53,v65,v66)
select v53, v66, v65 from aggJoin7209395098787936049 join aggView6258996481854352722 using(v53));
create or replace view aggJoin6207973303799869251 as (
with aggView4209600467082640468 as (select v53, MIN(v66) as v66, MIN(v65) as v65 from aggJoin8481144100315516292 group by v53,v65,v66)
select v66, v65 from aggJoin661254927882364150 join aggView4209600467082640468 using(v53));
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin6207973303799869251;
