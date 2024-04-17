create or replace view aggView7161593255992781309 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin2114251432576366440 as select movie_id as v12 from movie_companies as mc, aggView7161593255992781309 where mc.company_id=aggView7161593255992781309.v1;
create or replace view aggView8072181201163101842 as select v12 from aggJoin2114251432576366440 group by v12;
create or replace view aggJoin5807275844894831386 as select id as v12, title as v20 from title as t, aggView8072181201163101842 where t.id=aggView8072181201163101842.v12;
create or replace view aggView1694440790981434293 as select v12, MIN(v20) as v31 from aggJoin5807275844894831386 group by v12;
create or replace view aggJoin431150816771466194 as select keyword_id as v18, v31 from movie_keyword as mk, aggView1694440790981434293 where mk.movie_id=aggView1694440790981434293.v12;
create or replace view aggView1507212139875831842 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin6049457505747160379 as select v31 from aggJoin431150816771466194 join aggView1507212139875831842 using(v18);
select MIN(v31) as v31 from aggJoin6049457505747160379;
