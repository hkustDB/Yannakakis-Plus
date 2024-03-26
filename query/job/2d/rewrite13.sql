create or replace view aggView5732730374842987117 as select id as v12, title as v31 from title as t;
create or replace view aggJoin746427874282280781 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView5732730374842987117 where mc.movie_id=aggView5732730374842987117.v12;
create or replace view aggView2560953014528861719 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin7536724687085511975 as select movie_id as v12 from movie_keyword as mk, aggView2560953014528861719 where mk.keyword_id=aggView2560953014528861719.v18;
create or replace view aggView6226011772444632136 as select v12 from aggJoin7536724687085511975 group by v12;
create or replace view aggJoin535310405256208266 as select v1, v31 as v31 from aggJoin746427874282280781 join aggView6226011772444632136 using(v12);
create or replace view aggView4360823506437194932 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin4994297773653020580 as select v31 from aggJoin535310405256208266 join aggView4360823506437194932 using(v1);
select MIN(v31) as v31 from aggJoin4994297773653020580;
