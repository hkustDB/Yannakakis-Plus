create or replace view aggView5464216668474211229 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin3330349674116656619 as select movie_id as v12 from movie_companies as mc, aggView5464216668474211229 where mc.company_id=aggView5464216668474211229.v1;
create or replace view aggView7013219271615154288 as select v12 from aggJoin3330349674116656619 group by v12;
create or replace view aggJoin7550115597277208434 as select id as v12, title as v20 from title as t, aggView7013219271615154288 where t.id=aggView7013219271615154288.v12;
create or replace view aggView5751056685382914368 as select v12, MIN(v20) as v31 from aggJoin7550115597277208434 group by v12;
create or replace view aggJoin2901835591974943786 as select keyword_id as v18, v31 from movie_keyword as mk, aggView5751056685382914368 where mk.movie_id=aggView5751056685382914368.v12;
create or replace view aggView7647690363898606845 as select v18, MIN(v31) as v31 from aggJoin2901835591974943786 group by v18;
create or replace view aggJoin5943608130877639145 as select keyword as v9, v31 from keyword as k, aggView7647690363898606845 where k.id=aggView7647690363898606845.v18 and keyword= 'character-name-in-title';
select MIN(v31) as v31 from aggJoin5943608130877639145;
