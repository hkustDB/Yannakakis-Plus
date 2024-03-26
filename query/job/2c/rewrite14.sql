create or replace view aggView8237759728323802298 as select id as v12, title as v31 from title as t;
create or replace view aggJoin3151740616340812268 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView8237759728323802298 where mc.movie_id=aggView8237759728323802298.v12;
create or replace view aggView6893221974385425660 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin189738795968864009 as select movie_id as v12 from movie_keyword as mk, aggView6893221974385425660 where mk.keyword_id=aggView6893221974385425660.v18;
create or replace view aggView2354463233988402361 as select v12 from aggJoin189738795968864009 group by v12;
create or replace view aggJoin1579998882492137115 as select v1, v31 as v31 from aggJoin3151740616340812268 join aggView2354463233988402361 using(v12);
create or replace view aggView508799044690150829 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin6887136338743990917 as select v31 from aggJoin1579998882492137115 join aggView508799044690150829 using(v1);
select MIN(v31) as v31 from aggJoin6887136338743990917;
