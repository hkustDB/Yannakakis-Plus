create or replace view aggJoin7099986348076469089 as (
with aggView6897909112677003335 as (select id as v48, name as v72 from name as n where name LIKE '%An%' and gender= 'f')
select person_id as v48, v72 from aka_name as an, aggView6897909112677003335 where an.person_id=aggView6897909112677003335.v48);
create or replace view aggJoin5923443908018739298 as (
with aggView7347713271882729894 as (select id as v9, name as v71 from char_name as chn)
select person_id as v48, movie_id as v59, note as v20, role_id as v57, v71 from cast_info as ci, aggView7347713271882729894 where ci.person_role_id=aggView7347713271882729894.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin3560467548168898259 as (
with aggView5287056377609159110 as (select id as v59, title as v73 from title as t where production_year>2010)
select movie_id as v59, company_id as v23, v73 from movie_companies as mc, aggView5287056377609159110 where mc.movie_id=aggView5287056377609159110.v59);
create or replace view aggJoin3606558304924176036 as (
with aggView6718018024041972226 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView6718018024041972226 where mi.info_type_id=aggView6718018024041972226.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin6358397170789485761 as (
with aggView6133875016849100628 as (select id as v23 from company_name as cn where country_code= '[us]')
select v59, v73 from aggJoin3560467548168898259 join aggView6133875016849100628 using(v23));
create or replace view aggJoin9065074672273128417 as (
with aggView6308474625936108009 as (select v48, MIN(v72) as v72 from aggJoin7099986348076469089 group by v48,v72)
select v59, v20, v57, v71 as v71, v72 from aggJoin5923443908018739298 join aggView6308474625936108009 using(v48));
create or replace view aggJoin6846560652162684748 as (
with aggView19763262812575756 as (select id as v57 from role_type as rt where role= 'actress')
select v59, v20, v71, v72 from aggJoin9065074672273128417 join aggView19763262812575756 using(v57));
create or replace view aggJoin5533088023427065174 as (
with aggView6986317041319053154 as (select v59, MIN(v71) as v71, MIN(v72) as v72 from aggJoin6846560652162684748 group by v59,v72,v71)
select movie_id as v59, keyword_id as v32, v71, v72 from movie_keyword as mk, aggView6986317041319053154 where mk.movie_id=aggView6986317041319053154.v59);
create or replace view aggJoin385166896517148781 as (
with aggView3194005201495022423 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat'))
select v59, v71, v72 from aggJoin5533088023427065174 join aggView3194005201495022423 using(v32));
create or replace view aggJoin4746809168813750100 as (
with aggView4921291150584242631 as (select v59, MIN(v71) as v71, MIN(v72) as v72 from aggJoin385166896517148781 group by v59,v72,v71)
select v59, v73 as v73, v71, v72 from aggJoin6358397170789485761 join aggView4921291150584242631 using(v59));
create or replace view aggJoin1429919857749344769 as (
with aggView277261711491525790 as (select v59, MIN(v73) as v73, MIN(v71) as v71, MIN(v72) as v72 from aggJoin4746809168813750100 group by v59,v73,v72,v71)
select v73, v71, v72 from aggJoin3606558304924176036 join aggView277261711491525790 using(v59));
select MIN(v71) as v71,MIN(v72) as v72,MIN(v73) as v73 from aggJoin1429919857749344769;
