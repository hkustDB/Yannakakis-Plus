create or replace view aggJoin1075983797661034276 as (
with aggView520926065221393848 as (select id as v9, name as v71 from char_name as chn)
select person_id as v48, movie_id as v59, note as v20, role_id as v57, v71 from cast_info as ci, aggView520926065221393848 where ci.person_role_id=aggView520926065221393848.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin1199010806220648090 as (
with aggView3273151227218606407 as (select person_id as v48 from aka_name as an group by person_id)
select id as v48, name as v49, gender as v52 from name as n, aggView3273151227218606407 where n.id=aggView3273151227218606407.v48 and name LIKE '%An%' and gender= 'f');
create or replace view aggJoin6868121347344508703 as (
with aggView2017043863246315957 as (select v48, MIN(v49) as v72 from aggJoin1199010806220648090 group by v48)
select v59, v20, v57, v71 as v71, v72 from aggJoin1075983797661034276 join aggView2017043863246315957 using(v48));
create or replace view aggJoin2812664623262326384 as (
with aggView7602977395032816748 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView7602977395032816748 where mi.info_type_id=aggView7602977395032816748.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin6730645066864061408 as (
with aggView3924082014111926643 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v59 from movie_companies as mc, aggView3924082014111926643 where mc.company_id=aggView3924082014111926643.v23);
create or replace view aggJoin8030419309994785588 as (
with aggView3236774981410327588 as (select id as v57 from role_type as rt where role= 'actress')
select v59, v20, v71, v72 from aggJoin6868121347344508703 join aggView3236774981410327588 using(v57));
create or replace view aggJoin4686547963487613676 as (
with aggView2956582396037398284 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat'))
select movie_id as v59 from movie_keyword as mk, aggView2956582396037398284 where mk.keyword_id=aggView2956582396037398284.v32);
create or replace view aggJoin3636758842892347159 as (
with aggView2911261884730137167 as (select v59 from aggJoin4686547963487613676 group by v59)
select id as v59, title as v60, production_year as v63 from title as t, aggView2911261884730137167 where t.id=aggView2911261884730137167.v59 and production_year>2010);
create or replace view aggJoin7757911864848202112 as (
with aggView6261973513256661059 as (select v59, MIN(v60) as v73 from aggJoin3636758842892347159 group by v59)
select v59, v73 from aggJoin6730645066864061408 join aggView6261973513256661059 using(v59));
create or replace view aggJoin4682115702740945407 as (
with aggView2902027722662058203 as (select v59, MIN(v73) as v73 from aggJoin7757911864848202112 group by v59,v73)
select v59, v20, v71 as v71, v72 as v72, v73 from aggJoin8030419309994785588 join aggView2902027722662058203 using(v59));
create or replace view aggJoin527863704752670643 as (
with aggView8705927856408138132 as (select v59, MIN(v71) as v71, MIN(v72) as v72, MIN(v73) as v73 from aggJoin4682115702740945407 group by v59,v73,v72,v71)
select v71, v72, v73 from aggJoin2812664623262326384 join aggView8705927856408138132 using(v59));
select MIN(v71) as v71,MIN(v72) as v72,MIN(v73) as v73 from aggJoin527863704752670643;
