create or replace view aggView6968898874539304349 as select id as v1, name as v2 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin550539720624026079 as (
with aggView7820752487707546882 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView7820752487707546882 where mi_idx.info_type_id=aggView7820752487707546882.v12 and info<'7.0');
create or replace view aggView8933546558007542497 as select v32, v37 from aggJoin550539720624026079 group by v32,v37;
create or replace view aggJoin4455990901649073728 as (
with aggView4037453649038565281 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView4037453649038565281 where t.kind_id=aggView4037453649038565281.v17 and production_year>2008);
create or replace view aggView7785934099503329801 as select v38, v37 from aggJoin4455990901649073728 group by v38,v37;
create or replace view aggJoin1477143905093878923 as (
with aggView8096397235583953042 as (select v1, MIN(v2) as v49 from aggView6968898874539304349 group by v1)
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView8096397235583953042 where mc.company_id=aggView8096397235583953042.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin6802897135337996898 as (
with aggView2515362393552793599 as (select v37, MIN(v32) as v50 from aggView8933546558007542497 group by v37)
select v38, v37, v50 from aggView7785934099503329801 join aggView2515362393552793599 using(v37));
create or replace view aggJoin3884176611087781630 as (
with aggView5877454329960043537 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin1477143905093878923 join aggView5877454329960043537 using(v8));
create or replace view aggJoin7897705191604460046 as (
with aggView7962760452499393611 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView7962760452499393611 where mi.info_type_id=aggView7962760452499393611.v10 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin6821997584980342718 as (
with aggView3922172526213377493 as (select v37 from aggJoin7897705191604460046 group by v37)
select movie_id as v37, keyword_id as v14 from movie_keyword as mk, aggView3922172526213377493 where mk.movie_id=aggView3922172526213377493.v37);
create or replace view aggJoin4794688662380451126 as (
with aggView4883640309200461196 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v37 from aggJoin6821997584980342718 join aggView4883640309200461196 using(v14));
create or replace view aggJoin8206082669503482012 as (
with aggView1036867547916936985 as (select v37 from aggJoin4794688662380451126 group by v37)
select v37, v23, v49 as v49 from aggJoin3884176611087781630 join aggView1036867547916936985 using(v37));
create or replace view aggJoin6638223576338546119 as (
with aggView5967546784653861391 as (select v37, MIN(v49) as v49 from aggJoin8206082669503482012 group by v37,v49)
select v38, v50 as v50, v49 from aggJoin6802897135337996898 join aggView5967546784653861391 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v38) as v51 from aggJoin6638223576338546119;
