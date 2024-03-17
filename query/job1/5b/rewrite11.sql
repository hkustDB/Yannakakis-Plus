create or replace view aggView3866336703216651742 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin225868370800182422 as select movie_id as v15, note as v9 from movie_companies as mc, aggView3866336703216651742 where mc.company_type_id=aggView3866336703216651742.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView776871900143649618 as select v15 from aggJoin225868370800182422 group by v15;
create or replace view aggJoin4897628557918569463 as select movie_id as v15, info_type_id as v3, info as v13 from movie_info as mi, aggView776871900143649618 where mi.movie_id=aggView776871900143649618.v15 and info IN ('USA','America');
create or replace view aggView2353262334943992940 as select id as v3 from info_type as it;
create or replace view aggJoin3055862745852690485 as select v15, v13 from aggJoin4897628557918569463 join aggView2353262334943992940 using(v3);
create or replace view aggView1007068591196430779 as select v15 from aggJoin3055862745852690485 group by v15;
create or replace view aggJoin8237144205438334533 as select title as v16 from title as t, aggView1007068591196430779 where t.id=aggView1007068591196430779.v15 and production_year>2010;
select MIN(v16) as v27 from aggJoin8237144205438334533;
