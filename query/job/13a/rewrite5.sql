create or replace view aggJoin4804727197330091157 as (
with aggView9108012342136128968 as (select id as v8 from company_type as ct where kind= 'production companies')
select movie_id as v22, company_id as v1 from movie_companies as mc, aggView9108012342136128968 where mc.company_type_id=aggView9108012342136128968.v8);
create or replace view aggJoin3960660292391490501 as (
with aggView8304969331493617034 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView8304969331493617034 where miidx.info_type_id=aggView8304969331493617034.v10);
create or replace view aggView6019012745778963167 as select v22, v29 from aggJoin3960660292391490501 group by v22,v29;
create or replace view aggJoin1124562297870433842 as (
with aggView8374761564817542757 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22, info as v24 from movie_info as mi, aggView8374761564817542757 where mi.info_type_id=aggView8374761564817542757.v12);
create or replace view aggView2402213784029336587 as select v24, v22 from aggJoin1124562297870433842 group by v24,v22;
create or replace view aggJoin2892065466328928689 as (
with aggView6840798470574949646 as (select id as v1 from company_name as cn where country_code= '[de]')
select v22 from aggJoin4804727197330091157 join aggView6840798470574949646 using(v1));
create or replace view aggJoin601309388800485924 as (
with aggView5830048648480384142 as (select v22 from aggJoin2892065466328928689 group by v22)
select id as v22, title as v32, kind_id as v14 from title as t, aggView5830048648480384142 where t.id=aggView5830048648480384142.v22);
create or replace view aggJoin1686016895400465014 as (
with aggView7440874435787827541 as (select id as v14 from kind_type as kt where kind= 'movie')
select v22, v32 from aggJoin601309388800485924 join aggView7440874435787827541 using(v14));
create or replace view aggView2050328337955276674 as select v22, v32 from aggJoin1686016895400465014 group by v22,v32;
create or replace view aggJoin989033476736109522 as (
with aggView5428526476880614110 as (select v22, MIN(v32) as v45 from aggView2050328337955276674 group by v22)
select v22, v29, v45 from aggView6019012745778963167 join aggView5428526476880614110 using(v22));
create or replace view aggJoin2773480020999322173 as (
with aggView6885711741583783563 as (select v22, MIN(v45) as v45, MIN(v29) as v44 from aggJoin989033476736109522 group by v22,v45)
select v24, v45, v44 from aggView2402213784029336587 join aggView6885711741583783563 using(v22));
select MIN(v24) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin2773480020999322173;
