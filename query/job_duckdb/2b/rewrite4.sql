create or replace view aggView4752454800833857802 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin2118460440284660965 as select movie_id as v12 from movie_companies as mc, aggView4752454800833857802 where mc.company_id=aggView4752454800833857802.v1;
create or replace view aggView2148796294802756713 as select v12 from aggJoin2118460440284660965 group by v12;
create or replace view aggJoin6810606202191951276 as select id as v12, title as v20 from title as t, aggView2148796294802756713 where t.id=aggView2148796294802756713.v12;
create or replace view aggView9072906753610306570 as select v12, MIN(v20) as v31 from aggJoin6810606202191951276 group by v12;
create or replace view aggJoin7074457640024663591 as select keyword_id as v18, v31 from movie_keyword as mk, aggView9072906753610306570 where mk.movie_id=aggView9072906753610306570.v12;
create or replace view aggView1049918826128963440 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin2107905534220597908 as select v31 from aggJoin7074457640024663591 join aggView1049918826128963440 using(v18);
select MIN(v31) as v31 from aggJoin2107905534220597908;
