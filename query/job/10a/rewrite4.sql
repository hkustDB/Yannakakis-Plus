create or replace view aggView1388366432502217019 as select name as v2, id as v1 from char_name as chn;
create or replace view aggView3659752203666347506 as select id as v31, title as v32 from title as t where production_year>2005;
create or replace view aggJoin2224819967408917976 as (
with aggView3525880083201704137 as (select v31, MIN(v32) as v44 from aggView3659752203666347506 group by v31)
select movie_id as v31, person_role_id as v1, note as v12, role_id as v29, v44 from cast_info as ci, aggView3525880083201704137 where ci.movie_id=aggView3525880083201704137.v31 and note LIKE '%(voice)%' and note LIKE '%(uncredited)%');
create or replace view aggJoin6044828920600164236 as (
with aggView5242187372523010083 as (select id as v29 from role_type as rt where role= 'actor')
select v31, v1, v12, v44 from aggJoin2224819967408917976 join aggView5242187372523010083 using(v29));
create or replace view aggJoin4751129744350627456 as (
with aggView7446989595493322690 as (select id as v22 from company_type as ct)
select movie_id as v31, company_id as v15 from movie_companies as mc, aggView7446989595493322690 where mc.company_type_id=aggView7446989595493322690.v22);
create or replace view aggJoin18593083991424881 as (
with aggView3814719079238269129 as (select id as v15 from company_name as cn where country_code= '[ru]')
select v31 from aggJoin4751129744350627456 join aggView3814719079238269129 using(v15));
create or replace view aggJoin2090458631821894261 as (
with aggView2407184245670696156 as (select v31 from aggJoin18593083991424881 group by v31)
select v1, v12, v44 as v44 from aggJoin6044828920600164236 join aggView2407184245670696156 using(v31));
create or replace view aggJoin6014945276538667780 as (
with aggView7615165227280679112 as (select v1, MIN(v44) as v44 from aggJoin2090458631821894261 group by v1,v44)
select v2, v44 from aggView1388366432502217019 join aggView7615165227280679112 using(v1));
select MIN(v2) as v43,MIN(v44) as v44 from aggJoin6014945276538667780;
