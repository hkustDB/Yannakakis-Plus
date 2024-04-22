create or replace view aggJoin4317290073664762730 as (
with aggView1468906460562269619 as (select id as v1, name as v43 from company_name as cn where country_code= '[us]')
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView1468906460562269619 where mc.company_id=aggView1468906460562269619.v1);
create or replace view aggJoin5145973516845973747 as (
with aggView4162466585587562505 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin4317290073664762730 join aggView4162466585587562505 using(v8));
create or replace view aggJoin8628629997612416128 as (
with aggView4726602733024259571 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView4726602733024259571 where t.kind_id=aggView4726602733024259571.v14);
create or replace view aggJoin8350187525964472368 as (
with aggView7013504037384970966 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView7013504037384970966 where miidx.info_type_id=aggView7013504037384970966.v10);
create or replace view aggJoin319521555229955173 as (
with aggView8517141790330381498 as (select v22, MIN(v29) as v44 from aggJoin8350187525964472368 group by v22)
select v22, v32, v44 from aggJoin8628629997612416128 join aggView8517141790330381498 using(v22));
create or replace view aggJoin8006855554805561942 as (
with aggView1057830553890032139 as (select v22, MIN(v43) as v43 from aggJoin5145973516845973747 group by v22,v43)
select v22, v32, v44 as v44, v43 from aggJoin319521555229955173 join aggView1057830553890032139 using(v22));
create or replace view aggJoin6804753423573059067 as (
with aggView4314395783497353300 as (select v22, MIN(v44) as v44, MIN(v43) as v43, MIN(v32) as v45 from aggJoin8006855554805561942 group by v22,v43,v44)
select info_type_id as v12, v44, v43, v45 from movie_info as mi, aggView4314395783497353300 where mi.movie_id=aggView4314395783497353300.v22);
create or replace view aggJoin1920138164325800355 as (
with aggView4319571866229143862 as (select id as v12 from info_type as it2 where info= 'release dates')
select v44, v43, v45 from aggJoin6804753423573059067 join aggView4319571866229143862 using(v12));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin1920138164325800355;
