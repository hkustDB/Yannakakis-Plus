create or replace view aggView257766269367252983 as select name as v10, id as v9 from char_name as chn;
create or replace view aggView8051849353500366819 as select id as v48, name as v49 from name as n where name LIKE '%An%' and gender= 'f';
create or replace view aggJoin9147757922443775558 as (
with aggView640859499772536333 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView640859499772536333 where mi.info_type_id=aggView640859499772536333.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin801926858047015648 as (
with aggView3493882290670838816 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v59 from movie_companies as mc, aggView3493882290670838816 where mc.company_id=aggView3493882290670838816.v23);
create or replace view aggJoin2310137969097494355 as (
with aggView193208980506047757 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat'))
select movie_id as v59 from movie_keyword as mk, aggView193208980506047757 where mk.keyword_id=aggView193208980506047757.v32);
create or replace view aggJoin5422318497274834797 as (
with aggView1938446130587897888 as (select v59 from aggJoin2310137969097494355 group by v59)
select v59, v43 from aggJoin9147757922443775558 join aggView1938446130587897888 using(v59));
create or replace view aggJoin7916091436378270480 as (
with aggView9062903186362809724 as (select v59 from aggJoin5422318497274834797 group by v59)
select id as v59, title as v60, production_year as v63 from title as t, aggView9062903186362809724 where t.id=aggView9062903186362809724.v59 and production_year>2010);
create or replace view aggJoin4546946166969914015 as (
with aggView6146149038348642334 as (select v59 from aggJoin801926858047015648 group by v59)
select v59, v60, v63 from aggJoin7916091436378270480 join aggView6146149038348642334 using(v59));
create or replace view aggView6424350591751876646 as select v59, v60 from aggJoin4546946166969914015 group by v59,v60;
create or replace view aggJoin6885688733287734776 as (
with aggView5433711736104033701 as (select v9, MIN(v10) as v71 from aggView257766269367252983 group by v9)
select person_id as v48, movie_id as v59, note as v20, role_id as v57, v71 from cast_info as ci, aggView5433711736104033701 where ci.person_role_id=aggView5433711736104033701.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin4608250462274998281 as (
with aggView8313537720656940839 as (select v59, MIN(v60) as v73 from aggView6424350591751876646 group by v59)
select v48, v20, v57, v71 as v71, v73 from aggJoin6885688733287734776 join aggView8313537720656940839 using(v59));
create or replace view aggJoin4275786303469229879 as (
with aggView7465149485612920078 as (select person_id as v48 from aka_name as an group by person_id)
select v48, v20, v57, v71 as v71, v73 as v73 from aggJoin4608250462274998281 join aggView7465149485612920078 using(v48));
create or replace view aggJoin13698773406383530 as (
with aggView4062497737407487900 as (select id as v57 from role_type as rt where role= 'actress')
select v48, v20, v71, v73 from aggJoin4275786303469229879 join aggView4062497737407487900 using(v57));
create or replace view aggJoin8318798656300602160 as (
with aggView4955629412963220629 as (select v48, MIN(v71) as v71, MIN(v73) as v73 from aggJoin13698773406383530 group by v48,v73,v71)
select v49, v71, v73 from aggView8051849353500366819 join aggView4955629412963220629 using(v48));
select MIN(v71) as v71,MIN(v49) as v72,MIN(v73) as v73 from aggJoin8318798656300602160;
