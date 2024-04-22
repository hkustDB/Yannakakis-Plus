create or replace view aggView6730622356117110729 as select id as v1, name as v2 from company_name as cn where country_code= '[us]';
create or replace view aggJoin4527226030113635115 as (
with aggView4384596289929867930 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView4384596289929867930 where miidx.info_type_id=aggView4384596289929867930.v10);
create or replace view aggJoin5271552381929011554 as (
with aggView6086354091038912651 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView6086354091038912651 where mi.info_type_id=aggView6086354091038912651.v12);
create or replace view aggJoin1472754373700175544 as (
with aggView5624562965628136389 as (select v22 from aggJoin5271552381929011554 group by v22)
select v22, v29 from aggJoin4527226030113635115 join aggView5624562965628136389 using(v22));
create or replace view aggView8993650420293595927 as select v22, v29 from aggJoin1472754373700175544 group by v22,v29;
create or replace view aggJoin5125290002633548190 as (
with aggView4862691822197031090 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView4862691822197031090 where t.kind_id=aggView4862691822197031090.v14 and title<> '' and ((title LIKE 'Champion%') OR (title LIKE 'Loser%')));
create or replace view aggView899980603692094611 as select v32, v22 from aggJoin5125290002633548190 group by v32,v22;
create or replace view aggJoin498643657407807852 as (
with aggView4520042318470188495 as (select v22, MIN(v32) as v45 from aggView899980603692094611 group by v22)
select v22, v29, v45 from aggView8993650420293595927 join aggView4520042318470188495 using(v22));
create or replace view aggJoin857032797032412278 as (
with aggView6253970493569740378 as (select v22, MIN(v45) as v45, MIN(v29) as v44 from aggJoin498643657407807852 group by v22,v45)
select company_id as v1, company_type_id as v8, v45, v44 from movie_companies as mc, aggView6253970493569740378 where mc.movie_id=aggView6253970493569740378.v22);
create or replace view aggJoin3284997110486253562 as (
with aggView8761408837794839735 as (select id as v8 from company_type as ct where kind= 'production companies')
select v1, v45, v44 from aggJoin857032797032412278 join aggView8761408837794839735 using(v8));
create or replace view aggJoin923310061390640693 as (
with aggView6011755550604813390 as (select v1, MIN(v45) as v45, MIN(v44) as v44 from aggJoin3284997110486253562 group by v1,v45,v44)
select v2, v45, v44 from aggView6730622356117110729 join aggView6011755550604813390 using(v1));
select MIN(v2) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin923310061390640693;
