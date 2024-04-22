create or replace view aggJoin8675211704625039695 as (
with aggView8537967104288639425 as (select id as v59, title as v60 from title as t where production_year>2010)
select v59, v60 from aggView8537967104288639425 where v60 LIKE 'Kung Fu Panda%');
create or replace view aggJoin1824601788366008082 as (
with aggView7397185395237008980 as (select name as v49, id as v48 from name as n where gender= 'f')
select v48, v49 from aggView7397185395237008980 where v49 LIKE '%An%');
create or replace view aggView3001518717446640252 as select id as v9, name as v10 from char_name as chn;
create or replace view aggJoin733610112666767561 as (
with aggView6697332285122656121 as (select v9, MIN(v10) as v71 from aggView3001518717446640252 group by v9)
select person_id as v48, movie_id as v59, note as v20, role_id as v57, v71 from cast_info as ci, aggView6697332285122656121 where ci.person_role_id=aggView6697332285122656121.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin8983612065460535016 as (
with aggView6788128213354416945 as (select v48, MIN(v49) as v72 from aggJoin1824601788366008082 group by v48)
select v48, v59, v20, v57, v71 as v71, v72 from aggJoin733610112666767561 join aggView6788128213354416945 using(v48));
create or replace view aggJoin5246882333178081692 as (
with aggView4088740243426405859 as (select id as v57 from role_type as rt where role= 'actress')
select v48, v59, v20, v71, v72 from aggJoin8983612065460535016 join aggView4088740243426405859 using(v57));
create or replace view aggJoin2862003582156505579 as (
with aggView5088509706011512538 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView5088509706011512538 where mi.info_type_id=aggView5088509706011512538.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin393408744208779257 as (
with aggView3914786950804360945 as (select person_id as v48 from aka_name as an group by person_id)
select v59, v20, v71 as v71, v72 as v72 from aggJoin5246882333178081692 join aggView3914786950804360945 using(v48));
create or replace view aggJoin6184128180042665935 as (
with aggView5534460831817397354 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat','computer-animated-movie'))
select movie_id as v59 from movie_keyword as mk, aggView5534460831817397354 where mk.keyword_id=aggView5534460831817397354.v32);
create or replace view aggJoin2140280457934871241 as (
with aggView448657727750469965 as (select v59 from aggJoin6184128180042665935 group by v59)
select v59, v20, v71 as v71, v72 as v72 from aggJoin393408744208779257 join aggView448657727750469965 using(v59));
create or replace view aggJoin9222759780589046711 as (
with aggView2783264338933215014 as (select id as v23 from company_name as cn where country_code= '[us]' and name= 'DreamWorks Animation')
select movie_id as v59 from movie_companies as mc, aggView2783264338933215014 where mc.company_id=aggView2783264338933215014.v23);
create or replace view aggJoin1035893258871888912 as (
with aggView6196785572887685891 as (select v59 from aggJoin9222759780589046711 group by v59)
select v59, v20, v71 as v71, v72 as v72 from aggJoin2140280457934871241 join aggView6196785572887685891 using(v59));
create or replace view aggJoin6728171187001965044 as (
with aggView7028067943895579254 as (select v59 from aggJoin2862003582156505579 group by v59)
select v59, v20, v71 as v71, v72 as v72 from aggJoin1035893258871888912 join aggView7028067943895579254 using(v59));
create or replace view aggJoin4266087558709555617 as (
with aggView5806894558711858983 as (select v59, MIN(v71) as v71, MIN(v72) as v72 from aggJoin6728171187001965044 group by v59,v72,v71)
select v60, v71, v72 from aggJoin8675211704625039695 join aggView5806894558711858983 using(v59));
select MIN(v71) as v71,MIN(v72) as v72,MIN(v60) as v73 from aggJoin4266087558709555617;
