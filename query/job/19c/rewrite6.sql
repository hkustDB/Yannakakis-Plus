create or replace view aggView9200094843262928626 as select id as v53, title as v54 from title as t where production_year>2000;
create or replace view aggJoin8354689303104494109 as (
with aggView6568176270743614855 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView6568176270743614855 where n.id=aggView6568176270743614855.v42 and name LIKE '%An%' and gender= 'f');
create or replace view aggView3272035842736237474 as select v43, v42 from aggJoin8354689303104494109 group by v43,v42;
create or replace view aggJoin8303078249363949987 as (
with aggView7264388971281201118 as (select v53, MIN(v54) as v66 from aggView9200094843262928626 group by v53)
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v66 from cast_info as ci, aggView7264388971281201118 where ci.movie_id=aggView7264388971281201118.v53 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin4904248030764087318 as (
with aggView956999793255745973 as (select id as v51 from role_type as rt where role= 'actress')
select v42, v53, v9, v20, v66 from aggJoin8303078249363949987 join aggView956999793255745973 using(v51));
create or replace view aggJoin8862765583241981181 as (
with aggView7759774017546393613 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView7759774017546393613 where mi.info_type_id=aggView7759774017546393613.v30 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin1020679733374690054 as (
with aggView8160525890542373367 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView8160525890542373367 where mc.company_id=aggView8160525890542373367.v23);
create or replace view aggJoin5045378490036999350 as (
with aggView1569936472573805671 as (select v53 from aggJoin8862765583241981181 group by v53)
select v53 from aggJoin1020679733374690054 join aggView1569936472573805671 using(v53));
create or replace view aggJoin3173013382386569028 as (
with aggView1594712114884707580 as (select id as v9 from char_name as chn)
select v42, v53, v20, v66 from aggJoin4904248030764087318 join aggView1594712114884707580 using(v9));
create or replace view aggJoin9128230955582303507 as (
with aggView1052879515440333046 as (select v53 from aggJoin5045378490036999350 group by v53)
select v42, v20, v66 as v66 from aggJoin3173013382386569028 join aggView1052879515440333046 using(v53));
create or replace view aggJoin1457864563724310933 as (
with aggView6364720577184077767 as (select v42, MIN(v66) as v66 from aggJoin9128230955582303507 group by v42,v66)
select v43, v66 from aggView3272035842736237474 join aggView6364720577184077767 using(v42));
select MIN(v43) as v65,MIN(v66) as v66 from aggJoin1457864563724310933;
