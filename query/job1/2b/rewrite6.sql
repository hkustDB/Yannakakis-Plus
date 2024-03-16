create or replace view aggView1956058143091161340 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin4676252119201283873 as select movie_id as v12 from movie_companies as mc, aggView1956058143091161340 where mc.company_id=aggView1956058143091161340.v1;
create or replace view aggView3680014009187611940 as select v12 from aggJoin4676252119201283873 group by v12;
create or replace view aggJoin1145660281045575968 as select movie_id as v12, keyword_id as v18 from movie_keyword as mk, aggView3680014009187611940 where mk.movie_id=aggView3680014009187611940.v12;
create or replace view aggView1210925338477127438 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin243357314946806229 as select v12 from aggJoin1145660281045575968 join aggView1210925338477127438 using(v18);
create or replace view aggView7675847400255508071 as select v12 from aggJoin243357314946806229 group by v12;
create or replace view aggJoin8770657932522763340 as select title as v20 from title as t, aggView7675847400255508071 where t.id=aggView7675847400255508071.v12;
select MIN(v20) as v31 from aggJoin8770657932522763340;
