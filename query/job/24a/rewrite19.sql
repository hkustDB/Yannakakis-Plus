create or replace view aggJoin4480913417313054725 as (
with aggView261902771832271105 as (select id as v48, name as v49 from name as n where gender= 'f')
select v48, v49 from aggView261902771832271105 where v49 LIKE '%An%');
create or replace view aggView1159448532374952908 as select name as v10, id as v9 from char_name as chn;
create or replace view aggView2137271548724629434 as select id as v59, title as v60 from title as t where production_year>2010;
create or replace view aggJoin4368202541264146719 as (
with aggView3091441932991321425 as (select v59, MIN(v60) as v73 from aggView2137271548724629434 group by v59)
select person_id as v48, movie_id as v59, person_role_id as v9, note as v20, role_id as v57, v73 from cast_info as ci, aggView3091441932991321425 where ci.movie_id=aggView3091441932991321425.v59 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin5550351873581614039 as (
with aggView6383779250532476889 as (select v9, MIN(v10) as v71 from aggView1159448532374952908 group by v9)
select v48, v59, v20, v57, v73 as v73, v71 from aggJoin4368202541264146719 join aggView6383779250532476889 using(v9));
create or replace view aggJoin8333029168002483159 as (
with aggView2962340686899444794 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView2962340686899444794 where mi.info_type_id=aggView2962340686899444794.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin8611230561007679231 as (
with aggView739982975285443193 as (select v59 from aggJoin8333029168002483159 group by v59)
select v48, v59, v20, v57, v73 as v73, v71 as v71 from aggJoin5550351873581614039 join aggView739982975285443193 using(v59));
create or replace view aggJoin1520636253966557486 as (
with aggView3013643500520562169 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v59 from movie_companies as mc, aggView3013643500520562169 where mc.company_id=aggView3013643500520562169.v23);
create or replace view aggJoin9118850891317035375 as (
with aggView5085688392242836140 as (select v59 from aggJoin1520636253966557486 group by v59)
select v48, v59, v20, v57, v73 as v73, v71 as v71 from aggJoin8611230561007679231 join aggView5085688392242836140 using(v59));
create or replace view aggJoin2816723251101720775 as (
with aggView751732872495088382 as (select person_id as v48 from aka_name as an group by person_id)
select v48, v59, v20, v57, v73 as v73, v71 as v71 from aggJoin9118850891317035375 join aggView751732872495088382 using(v48));
create or replace view aggJoin5534324257345795733 as (
with aggView1142530903657724262 as (select id as v57 from role_type as rt where role= 'actress')
select v48, v59, v20, v73, v71 from aggJoin2816723251101720775 join aggView1142530903657724262 using(v57));
create or replace view aggJoin4788645735661754998 as (
with aggView422607809620521973 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat'))
select movie_id as v59 from movie_keyword as mk, aggView422607809620521973 where mk.keyword_id=aggView422607809620521973.v32);
create or replace view aggJoin8667280301486553031 as (
with aggView611758528222942400 as (select v59 from aggJoin4788645735661754998 group by v59)
select v48, v20, v73 as v73, v71 as v71 from aggJoin5534324257345795733 join aggView611758528222942400 using(v59));
create or replace view aggJoin5838581760213692595 as (
with aggView9044357836711841024 as (select v48, MIN(v73) as v73, MIN(v71) as v71 from aggJoin8667280301486553031 group by v48,v73,v71)
select v49, v73, v71 from aggJoin4480913417313054725 join aggView9044357836711841024 using(v48));
select MIN(v71) as v71,MIN(v49) as v72,MIN(v73) as v73 from aggJoin5838581760213692595;
