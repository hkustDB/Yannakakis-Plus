create or replace view aggView6866256484184085684 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin796194584612487179 as select movie_id as v12 from movie_companies as mc, aggView6866256484184085684 where mc.company_id=aggView6866256484184085684.v1;
create or replace view aggView6067168567841486692 as select v12 from aggJoin796194584612487179 group by v12;
create or replace view aggJoin7477885624830056474 as select id as v12, title as v20 from title as t, aggView6067168567841486692 where t.id=aggView6067168567841486692.v12;
create or replace view aggView8487592494815865035 as select v12, MIN(v20) as v31 from aggJoin7477885624830056474 group by v12;
create or replace view aggJoin7017929114505055556 as select keyword_id as v18, v31 from movie_keyword as mk, aggView8487592494815865035 where mk.movie_id=aggView8487592494815865035.v12;
create or replace view aggView8733093569629741827 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin7888752008908842531 as select v31 from aggJoin7017929114505055556 join aggView8733093569629741827 using(v18);
select MIN(v31) as v31 from aggJoin7888752008908842531;
