create or replace view aggView2555762865160189991 as select id as v12, title as v31 from title as t;
create or replace view aggJoin1348176871611643089 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView2555762865160189991 where mk.movie_id=aggView2555762865160189991.v12;
create or replace view aggView4705473133428241406 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin882701849425948449 as select v12, v31 from aggJoin1348176871611643089 join aggView4705473133428241406 using(v18);
create or replace view aggView7308679768640637497 as select v12, MIN(v31) as v31 from aggJoin882701849425948449 group by v12;
create or replace view aggJoin9160630727689278238 as select company_id as v1, v31 from movie_companies as mc, aggView7308679768640637497 where mc.movie_id=aggView7308679768640637497.v12;
create or replace view aggView453276178718432835 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin7725191463426002236 as select v31 from aggJoin9160630727689278238 join aggView453276178718432835 using(v1);
select MIN(v31) as v31 from aggJoin7725191463426002236;
