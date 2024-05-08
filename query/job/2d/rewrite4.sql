create or replace view aggView3257595226156852226 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin7309363902405782317 as select movie_id as v12 from movie_companies as mc, aggView3257595226156852226 where mc.company_id=aggView3257595226156852226.v1;
create or replace view aggView912270001975705804 as select v12 from aggJoin7309363902405782317 group by v12;
create or replace view aggJoin728462741185648277 as select id as v12, title as v20 from title as t, aggView912270001975705804 where t.id=aggView912270001975705804.v12;
create or replace view aggView7271289337232138632 as select v12, MIN(v20) as v31 from aggJoin728462741185648277 group by v12;
create or replace view aggJoin5022325014541581048 as select keyword_id as v18, v31 from movie_keyword as mk, aggView7271289337232138632 where mk.movie_id=aggView7271289337232138632.v12;
create or replace view aggView162950662332003864 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin1886210111378084037 as select v31 from aggJoin5022325014541581048 join aggView162950662332003864 using(v18);
select MIN(v31) as v31 from aggJoin1886210111378084037;
