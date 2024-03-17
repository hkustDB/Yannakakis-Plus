create or replace view aggView6955495223671699169 as select id as v12, title as v31 from title as t;
create or replace view aggJoin6760406896324598523 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView6955495223671699169 where mk.movie_id=aggView6955495223671699169.v12;
create or replace view aggView7186269190506878881 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin5543123757910457178 as select movie_id as v12 from movie_companies as mc, aggView7186269190506878881 where mc.company_id=aggView7186269190506878881.v1;
create or replace view aggView7245575657560062967 as select v12 from aggJoin5543123757910457178 group by v12;
create or replace view aggJoin8824498782104452596 as select v18, v31 as v31 from aggJoin6760406896324598523 join aggView7245575657560062967 using(v12);
create or replace view aggView6153086662711123908 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin1784583373127622792 as select v31 from aggJoin8824498782104452596 join aggView6153086662711123908 using(v18);
select MIN(v31) as v31 from aggJoin1784583373127622792;
