create or replace view aggView8916360214256819676 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin1026728268162345592 as select movie_id as v12 from movie_keyword as mk, aggView8916360214256819676 where mk.keyword_id=aggView8916360214256819676.v18;
create or replace view aggView7631718555084217129 as select v12 from aggJoin1026728268162345592 group by v12;
create or replace view aggJoin375341882968740803 as select id as v12, title as v20 from title as t, aggView7631718555084217129 where t.id=aggView7631718555084217129.v12;
create or replace view aggView7908845301064352018 as select v12, MIN(v20) as v31 from aggJoin375341882968740803 group by v12;
create or replace view aggJoin8079951454150529476 as select company_id as v1, v31 from movie_companies as mc, aggView7908845301064352018 where mc.movie_id=aggView7908845301064352018.v12;
create or replace view aggView6752631702757126732 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin1418152809834803426 as select v31 from aggJoin8079951454150529476 join aggView6752631702757126732 using(v1);
select MIN(v31) as v31 from aggJoin1418152809834803426;
