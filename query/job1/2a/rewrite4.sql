create or replace view aggView2971964889932087562 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin2134531255517888832 as select movie_id as v12 from movie_keyword as mk, aggView2971964889932087562 where mk.keyword_id=aggView2971964889932087562.v18;
create or replace view aggView8185743071714225856 as select v12 from aggJoin2134531255517888832 group by v12;
create or replace view aggJoin3195761659305171732 as select id as v12, title as v20 from title as t, aggView8185743071714225856 where t.id=aggView8185743071714225856.v12;
create or replace view aggView1024972784236099243 as select v12, MIN(v20) as v31 from aggJoin3195761659305171732 group by v12;
create or replace view aggJoin8146454924705852386 as select company_id as v1, v31 from movie_companies as mc, aggView1024972784236099243 where mc.movie_id=aggView1024972784236099243.v12;
create or replace view aggView4507641091118893843 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin5756425575446324486 as select v31 from aggJoin8146454924705852386 join aggView4507641091118893843 using(v1);
select MIN(v31) as v31 from aggJoin5756425575446324486;
