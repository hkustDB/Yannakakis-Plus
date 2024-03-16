create or replace view aggView9054294288996768882 as select id as v12, title as v31 from title as t;
create or replace view aggJoin97496207735383695 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView9054294288996768882 where mk.movie_id=aggView9054294288996768882.v12;
create or replace view aggView1928112711457004834 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin2594331864157365766 as select movie_id as v12 from movie_companies as mc, aggView1928112711457004834 where mc.company_id=aggView1928112711457004834.v1;
create or replace view aggView1293696147231433402 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin4286790828618181124 as select v12, v31 from aggJoin97496207735383695 join aggView1293696147231433402 using(v18);
create or replace view aggView233729062106905392 as select v12, MIN(v31) as v31 from aggJoin4286790828618181124 group by v12;
create or replace view aggJoin6155041457523816508 as select v31 from aggJoin2594331864157365766 join aggView233729062106905392 using(v12);
select MIN(v31) as v31 from aggJoin6155041457523816508;
