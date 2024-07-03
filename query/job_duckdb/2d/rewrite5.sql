create or replace view aggView3034098753891147309 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin7386819128961914630 as select movie_id as v12 from movie_companies as mc, aggView3034098753891147309 where mc.company_id=aggView3034098753891147309.v1;
create or replace view aggView3464171632263742745 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin82842389862650596 as select movie_id as v12 from movie_keyword as mk, aggView3464171632263742745 where mk.keyword_id=aggView3464171632263742745.v18;
create or replace view aggView4540778723271664724 as select v12 from aggJoin7386819128961914630 group by v12;
create or replace view aggJoin4177982656763757863 as select v12 from aggJoin82842389862650596 join aggView4540778723271664724 using(v12);
create or replace view aggView6595005252909002270 as select id as v12, title as v31 from title as t;
create or replace view aggJoin6422018556233500685 as select v31 from aggJoin4177982656763757863 join aggView6595005252909002270 using(v12);
select MIN(v31) as v31 from aggJoin6422018556233500685;
