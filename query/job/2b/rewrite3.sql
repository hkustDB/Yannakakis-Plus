create or replace view aggView4557643231232935821 as select id as v12, title as v31 from title as t;
create or replace view aggJoin8761236084967471612 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView4557643231232935821 where mc.movie_id=aggView4557643231232935821.v12;
create or replace view aggView632489652520760313 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin6348069206618115188 as select v12, v31 from aggJoin8761236084967471612 join aggView632489652520760313 using(v1);
create or replace view aggView7804795261496474952 as select v12, MIN(v31) as v31 from aggJoin6348069206618115188 group by v12;
create or replace view aggJoin5573106080822804860 as select keyword_id as v18, v31 from movie_keyword as mk, aggView7804795261496474952 where mk.movie_id=aggView7804795261496474952.v12;
create or replace view aggView6987964139157820630 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin3948984328286703281 as select v31 from aggJoin5573106080822804860 join aggView6987964139157820630 using(v18);
select MIN(v31) as v31 from aggJoin3948984328286703281;
