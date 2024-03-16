create or replace view aggView7213536407759949714 as select id as v12, title as v31 from title as t;
create or replace view aggJoin7184297198214862686 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView7213536407759949714 where mk.movie_id=aggView7213536407759949714.v12;
create or replace view aggView4851253922667481882 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin3055892303456599493 as select movie_id as v12 from movie_companies as mc, aggView4851253922667481882 where mc.company_id=aggView4851253922667481882.v1;
create or replace view aggView8787346975394158541 as select v12 from aggJoin3055892303456599493 group by v12;
create or replace view aggJoin7775106814846509432 as select v18, v31 as v31 from aggJoin7184297198214862686 join aggView8787346975394158541 using(v12);
create or replace view aggView4902489527605269144 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin2138886298226220487 as select v31 from aggJoin7775106814846509432 join aggView4902489527605269144 using(v18);
select MIN(v31) as v31 from aggJoin2138886298226220487;
