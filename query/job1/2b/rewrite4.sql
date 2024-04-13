create or replace view aggView76926521167063731 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin720848234926368890 as select movie_id as v12 from movie_companies as mc, aggView76926521167063731 where mc.company_id=aggView76926521167063731.v1;
create or replace view aggView1031433771565211347 as select v12 from aggJoin720848234926368890 group by v12;
create or replace view aggJoin2043052077974503356 as select id as v12, title as v20 from title as t, aggView1031433771565211347 where t.id=aggView1031433771565211347.v12;
create or replace view aggView3937502952430661414 as select v12, MIN(v20) as v31 from aggJoin2043052077974503356 group by v12;
create or replace view aggJoin3733463338391451315 as select keyword_id as v18, v31 from movie_keyword as mk, aggView3937502952430661414 where mk.movie_id=aggView3937502952430661414.v12;
create or replace view aggView305956925092516989 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin6480450920017558034 as select v31 from aggJoin3733463338391451315 join aggView305956925092516989 using(v18);
select MIN(v31) as v31 from aggJoin6480450920017558034;
