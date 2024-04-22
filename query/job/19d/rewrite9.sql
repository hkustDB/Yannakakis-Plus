create or replace view aggView6896917254253447549 as select id as v42, name as v43 from name as n where gender= 'f';
create or replace view aggJoin6711054187443616661 as (
with aggView7907040326071239161 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView7907040326071239161 where mc.company_id=aggView7907040326071239161.v23);
create or replace view aggJoin8472668477051481805 as (
with aggView2864669283459039489 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53 from movie_info as mi, aggView2864669283459039489 where mi.info_type_id=aggView2864669283459039489.v30);
create or replace view aggJoin4030544996232414601 as (
with aggView7649305659976549907 as (select v53 from aggJoin6711054187443616661 group by v53)
select v53 from aggJoin8472668477051481805 join aggView7649305659976549907 using(v53));
create or replace view aggJoin2213332231950013831 as (
with aggView2362161764577832533 as (select v53 from aggJoin4030544996232414601 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView2362161764577832533 where t.id=aggView2362161764577832533.v53 and production_year>2000);
create or replace view aggView7322373058803308816 as select v53, v54 from aggJoin2213332231950013831 group by v53,v54;
create or replace view aggJoin3144218791101109731 as (
with aggView3280378151962187172 as (select v53, MIN(v54) as v66 from aggView7322373058803308816 group by v53)
select person_id as v42, person_role_id as v9, note as v20, role_id as v51, v66 from cast_info as ci, aggView3280378151962187172 where ci.movie_id=aggView3280378151962187172.v53 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin428107970645506955 as (
with aggView8853625589411049107 as (select person_id as v42 from aka_name as an group by person_id)
select v42, v9, v20, v51, v66 as v66 from aggJoin3144218791101109731 join aggView8853625589411049107 using(v42));
create or replace view aggJoin883309374394420035 as (
with aggView970663828689820907 as (select id as v51 from role_type as rt where role= 'actress')
select v42, v9, v20, v66 from aggJoin428107970645506955 join aggView970663828689820907 using(v51));
create or replace view aggJoin8186185083800034775 as (
with aggView7554376441116802409 as (select id as v9 from char_name as chn)
select v42, v20, v66 from aggJoin883309374394420035 join aggView7554376441116802409 using(v9));
create or replace view aggJoin438349082815381380 as (
with aggView6237590762060752199 as (select v42, MIN(v66) as v66 from aggJoin8186185083800034775 group by v42,v66)
select v43, v66 from aggView6896917254253447549 join aggView6237590762060752199 using(v42));
select MIN(v43) as v65,MIN(v66) as v66 from aggJoin438349082815381380;
