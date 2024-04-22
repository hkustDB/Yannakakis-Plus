create or replace view aggJoin5019805947880938693 as (
with aggView9214503535969795296 as (select id as v53, title as v66 from title as t where production_year>2000)
select movie_id as v53, company_id as v23, v66 from movie_companies as mc, aggView9214503535969795296 where mc.movie_id=aggView9214503535969795296.v53);
create or replace view aggJoin4119571147624843352 as (
with aggView2302290377754915769 as (select id as v51 from role_type as rt where role= 'actress')
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20 from cast_info as ci, aggView2302290377754915769 where ci.role_id=aggView2302290377754915769.v51 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin5118085971661135284 as (
with aggView1407819617943819283 as (select id as v23 from company_name as cn where country_code= '[us]')
select v53, v66 from aggJoin5019805947880938693 join aggView1407819617943819283 using(v23));
create or replace view aggJoin6910732883958804274 as (
with aggView5057193198297820460 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53 from movie_info as mi, aggView5057193198297820460 where mi.info_type_id=aggView5057193198297820460.v30);
create or replace view aggJoin2271468031769334390 as (
with aggView1160064739221968441 as (select id as v9 from char_name as chn)
select v42, v53, v20 from aggJoin4119571147624843352 join aggView1160064739221968441 using(v9));
create or replace view aggJoin4365816814471928838 as (
with aggView7979493054975357294 as (select v53, MIN(v66) as v66 from aggJoin5118085971661135284 group by v53,v66)
select v53, v66 from aggJoin6910732883958804274 join aggView7979493054975357294 using(v53));
create or replace view aggJoin4202671756171154473 as (
with aggView2530655170719108132 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView2530655170719108132 where n.id=aggView2530655170719108132.v42 and gender= 'f');
create or replace view aggJoin5263323716973919368 as (
with aggView2925383710632724146 as (select v42, MIN(v43) as v65 from aggJoin4202671756171154473 group by v42)
select v53, v20, v65 from aggJoin2271468031769334390 join aggView2925383710632724146 using(v42));
create or replace view aggJoin4105015330030499231 as (
with aggView1341882644540587865 as (select v53, MIN(v65) as v65 from aggJoin5263323716973919368 group by v53,v65)
select v66 as v66, v65 from aggJoin4365816814471928838 join aggView1341882644540587865 using(v53));
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin4105015330030499231;
