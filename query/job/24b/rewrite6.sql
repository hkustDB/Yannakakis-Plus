create or replace view aggView4336766172442549277 as select id as v9, name as v10 from char_name as chn;
create or replace view aggJoin3816979508036660541 as (
with aggView2562122721991016968 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView2562122721991016968 where mi.info_type_id=aggView2562122721991016968.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin7130681851277253566 as (
with aggView6502068360332520262 as (select v59 from aggJoin3816979508036660541 group by v59)
select id as v59, title as v60, production_year as v63 from title as t, aggView6502068360332520262 where t.id=aggView6502068360332520262.v59 and production_year>2010);
create or replace view aggJoin8990850930243898544 as (
with aggView8917520945357655281 as (select person_id as v48 from aka_name as an group by person_id)
select id as v48, name as v49, gender as v52 from name as n, aggView8917520945357655281 where n.id=aggView8917520945357655281.v48 and gender= 'f');
create or replace view aggJoin4944382218964754329 as (
with aggView1561801917448282662 as (select v49, v48 from aggJoin8990850930243898544 group by v49,v48)
select v48, v49 from aggView1561801917448282662 where v49 LIKE '%An%');
create or replace view aggJoin7665683845737150244 as (
with aggView5288903363463972193 as (select id as v23 from company_name as cn where country_code= '[us]' and name= 'DreamWorks Animation')
select movie_id as v59 from movie_companies as mc, aggView5288903363463972193 where mc.company_id=aggView5288903363463972193.v23);
create or replace view aggJoin2118005819961792856 as (
with aggView5838254272912650425 as (select v59 from aggJoin7665683845737150244 group by v59)
select v59, v60, v63 from aggJoin7130681851277253566 join aggView5838254272912650425 using(v59));
create or replace view aggJoin4038812126857103646 as (
with aggView864720938538112342 as (select v59, v60 from aggJoin2118005819961792856 group by v59,v60)
select v59, v60 from aggView864720938538112342 where v60 LIKE 'Kung Fu Panda%');
create or replace view aggJoin6653268875761185717 as (
with aggView1734657536588708564 as (select v48, MIN(v49) as v72 from aggJoin4944382218964754329 group by v48)
select movie_id as v59, person_role_id as v9, note as v20, role_id as v57, v72 from cast_info as ci, aggView1734657536588708564 where ci.person_id=aggView1734657536588708564.v48 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin9064721819397257916 as (
with aggView6300957562280043735 as (select v59, MIN(v60) as v73 from aggJoin4038812126857103646 group by v59)
select v59, v9, v20, v57, v72 as v72, v73 from aggJoin6653268875761185717 join aggView6300957562280043735 using(v59));
create or replace view aggJoin1506931571531845144 as (
with aggView5519608769255605435 as (select id as v57 from role_type as rt where role= 'actress')
select v59, v9, v20, v72, v73 from aggJoin9064721819397257916 join aggView5519608769255605435 using(v57));
create or replace view aggJoin8931731411736297376 as (
with aggView7612122578621879724 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat','computer-animated-movie'))
select movie_id as v59 from movie_keyword as mk, aggView7612122578621879724 where mk.keyword_id=aggView7612122578621879724.v32);
create or replace view aggJoin7976024420414668799 as (
with aggView6477086860022729691 as (select v59 from aggJoin8931731411736297376 group by v59)
select v9, v20, v72 as v72, v73 as v73 from aggJoin1506931571531845144 join aggView6477086860022729691 using(v59));
create or replace view aggJoin3210706407586544937 as (
with aggView689095620765522853 as (select v9, MIN(v72) as v72, MIN(v73) as v73 from aggJoin7976024420414668799 group by v9,v72,v73)
select v10, v72, v73 from aggView4336766172442549277 join aggView689095620765522853 using(v9));
select MIN(v10) as v71,MIN(v72) as v72,MIN(v73) as v73 from aggJoin3210706407586544937;
